class Spree::BlogEntry < ApplicationRecord
  extend Mobility
  translates :title, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :body, type: :string,  fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :summary, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  # translates :tags, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  # translates :categories, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  before_save :create_permalink
  before_save :set_published_at
  validates_presence_of :title
  validates_presence_of :body

  default_scope { order("published_at DESC") }
  scope :visible, -> { where :visible => true }
  scope :project, -> { where :project => true }
  scope :recent, lambda{|max=5| visible.limit(max) }

  if Spree.user_class
    belongs_to :author, :class_name => Spree.user_class.to_s
  else
    belongs_to :author
  end

  has_one :blog_entry_image, :as => :viewable, :dependent => :destroy, :class_name => 'Spree::BlogEntryImage'
  accepts_nested_attributes_for :blog_entry_image, :reject_if => :all_blank

  def entry_summary(chars=200)
    if summary.blank?
      unless body.nil?
      "#{body[0...chars]}..." 
      else
        "No translation"
      end
    else
      summary
    end
  end

  def self.by_date(date, period = nil)
    if !date.is_a?(Date)
      keys = [:day, :month, :year].select {|key| date.include?(key) }
      period = keys.first.to_s
      date = DateTime.new(*keys.reverse.map {|key| date[key].to_i })
    end

    time = date.to_time.in_time_zone
    where(:published_at => (time.send("beginning_of_#{period}")..time.send("end_of_#{period}")) )
  end

  def self.by_tag(tag_name)
  end

  def self.by_category(category_name)
    tagged_with(category_name, :on => :categories)
  end

  def self.by_author(author)
    where(:author_id => author)
  end

  # data for news archive widget, only visible entries
  def self.organize_blog_entries
    Hash.new.tap do |entries|
      years.each do |year|
        months_for(year).each do |month|
          date = DateTime.new(year, month)
          entries[year] ||= []
          entries[year] << [date.strftime("%B"), self.visible.by_date(date, :month)]
        end
      end
    end
  end

  private

  def self.years
    visible.map {|e| e.published_at.year }.uniq
  end

  def self.months_for(year)
    visible.select {|e| e.published_at.year == year }.map {|e| e.published_at.month }.uniq
  end

  def create_permalink
    self.permalink = title.to_url if permalink.blank?
  end

  def set_published_at
    self.published_at = Time.now if published_at.blank?
  end

  def validate
    # nicEdit field contains "<br>" when blank
    errors.add(:body, "can't be blank") if body =~ /^<br>$/
  end

end
