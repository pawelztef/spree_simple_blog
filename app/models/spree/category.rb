class Spree::Category < ApplicationRecord
  extend Mobility
  translates :name, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  has_and_belongs_to_many :blog_entries
end
