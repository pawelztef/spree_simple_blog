class Spree::BlogEntry < ApplicationRecord
  extend Mobility
  translates :title, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :body, type: :string,  fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :summary, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :permalink, type: :string,  fallthrough_accessors: true
  before_save :set_published_at
  validates_presence_of :title
  validates_presence_of :body
  validates :title, uniqueness: true
  validates :permalink, uniqueness: true

  default_scope { order("published_at DESC") }
  scope :visible, -> { where :visible => true }
  scope :project, -> { where :project => true }
  scope :recent, lambda{|max=5| visible.limit(max) }

  if Spree.user_class
    belongs_to :author, :class_name => Spree.user_class.to_s
  else
    belongs_to :author
  end

  has_and_belongs_to_many :genres
  has_and_belongs_to_many :tags

  has_one :blog_entry_image, :as => :viewable, :dependent => :destroy, :class_name => 'Spree::BlogEntryImage'
  accepts_nested_attributes_for :blog_entry_image

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

  def self.by_tag(tag_slug)
    Spree::Tag.i18n.find_by_slug(tag_slug).blog_entries
  end

  def self.by_category(category_slug)
    Spree::Genre.i18n.find_by_slug(category_slug).blog_entries
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

  def create_permalink
    SpreeI18n::Config.available_locales.each do |loc|
      if self.permalink(locale: loc).blank?
        Mobility.with_locale(loc) do
          self.permalink = title.parameterize if title
        end
      else
        self.permalink = permalink.parameterize
      end
    end
  end

  private

  def self.find_by_permalink!(perma)
    self.i18n.find_by(permalink: perma)
  end

  def self.years
    visible.map {|e| e.published_at.year }.uniq
  end

  def self.months_for(year)
    visible.select {|e| e.published_at.year == year }.map {|e| e.published_at.month }.uniq
  end


  def set_published_at
    self.published_at = Time.now if published_at.blank?
  end

  def validate
    # nicEdit field contains "<br>" when blank
    errors.add(:body, "can't be blank") if body =~ /^<br>$/
  end

end
