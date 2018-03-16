Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_configuration',
  name: 'about_links_menu',
  insert_bottom: '[data-hook="admin_configurations_sidebar_menu"]',
  text: '<%= configurations_sidebar_menu_item Spree.t(:bio),
        admin_mes_url if can? :manage, Spree::Config %>'
)

