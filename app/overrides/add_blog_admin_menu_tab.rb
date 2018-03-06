Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "blog_admin_tabs",
                     :insert_bottom => "#main-sidebar",
                     :text => "
<ul class='nav nav-sidebar'>
  <li class='sidebar-menu-item'>
     <a data-toggle='collapse' data-parent='#sidebar' href='#sidebar-blog'>
       <span class='glyphicon glyphicon-text-color'></span><span class='text'> Blog</span><span class='icon icon-chevron-left pull-right'></span>
     </a>
    <ul id='sidebar-blog' class='collapse nav nav-pills nav-stacked' data-hook='admin_blog_sub_tabs'>
     <li class='sidebar-menu-item'><%= link_to Spree.t(:blog_entries), admin_blog_entries_path %></li>
     <li class='sidebar-menu-item'><%= link_to Spree.t(:genres), admin_genres_path %></li>
     <li class='sidebar-menu-item'><%= link_to Spree.t(:tags), admin_tags_path %></li>
    </ul>
  </li>
</ul>
                              ",
                     :disabled => false)

