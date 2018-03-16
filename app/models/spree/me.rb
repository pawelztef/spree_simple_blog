class Spree::Me < ApplicationRecord
  extend Mobility
  translates :fullname, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :email, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :phone, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :address_line1, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :address_line2, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :address_line3, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true
  translates :bio, type: :string, fallbacks: { pl: :en, en: :pl },  fallthrough_accessors: true

  has_attached_file :profile_image, styles: {thumb: "100x100#"},
    default_style: :thumb, 
    url: "/assets/profile_images/:id/:style/:basename.:extension",
    path: ":rails_root/public/assets/profile_images/:id/:style/:basename.:extension"
  validates_attachment :profile_image, presence: true
  validates_attachment_content_type :profile_image, content_type: /\Aimage/
  validates_attachment_file_name :profile_image, matches: [/png\z/, /jpe?g\z/ ]
  validates_presence_of :fullname
end
