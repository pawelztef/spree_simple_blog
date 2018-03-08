class Spree::BlogEntryImage < Spree::Image
  has_attached_file :attachment, 
     :styles => {:mini => '48x48#', :normal => '200x200>', :large => '600x600>', :original => '1024x1024>' },
     :default_style => :large,
     :url => "/assets/blog_entry_images/:id/:style/:basename.:extension",
     :path => ":rails_root/public/assets/blog_entry_images/:id/:style/:basename.:extension"  
  validates :attachment, attachment_presence: true
end
