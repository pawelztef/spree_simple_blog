Deface::Override.new(:virtual_path => "spree/admin/users/_form",
                     :name => "admin_author_info_fields",
                     :insert_bottom => "[data-hook='admin_user_form_fields']",
                     :partial => "spree/admin/users/author_info_fields",
                     :disabled => false)

Deface::Override.new(:virtual_path => "spree/admin/users/_form",
                     :name => "style_author_fileds",
                     :replace => "strong",
                     :text => "<label class='roles-label'>Roles</label>",
                     :disabled => false)

Deface::Override.new(:virtual_path => "spree/admin/users/_form",
                     :name => "style_role_checkboxs",
                     :set_attributes => "div.checkbox",
                     :attributes => {:class => 'checkbox-role'},
                     :disabled => false)
