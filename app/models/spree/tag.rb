class Spree::Tag < ApplicationRecord
  extend Mobility
  has_and_belongs_to_many :blog_entries
  validates_presence_of :name
end
