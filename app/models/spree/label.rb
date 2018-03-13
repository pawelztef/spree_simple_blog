class Spree::Label < ApplicationRecord
  extend Mobility
  translates :name, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :slug, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true

  has_and_belongs_to_many :blog_entries
  validates_presence_of :name
  validates :name, length: { minimum: 2, maximum: 26 }

end