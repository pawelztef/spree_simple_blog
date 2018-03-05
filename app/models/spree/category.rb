class Spree::Category < ApplicationRecord
  has_and_belongs_to_many :blog_entries
end
