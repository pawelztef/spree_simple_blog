class Spree::Tag < ApplicationRecord
  extend Mobility
  translates :name, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :slug, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true

  has_and_belongs_to_many :blog_entries
  validates_presence_of :name

  before_save :update_slug

  def update_slug
    self.slug = name.parameterize
  end
end
