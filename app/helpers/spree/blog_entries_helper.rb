module Spree
  module BlogEntriesHelper

    def post_link_list
      link = Struct.new(:name,:url)
      BlogEntry.recent.collect { |post| link.new( post.title, blog_entry_permalink(post)) }
    end

    def blog_entry_permalink(e)
      if e.project
        project_path :slug => e.permalink
      else
        blog_entry_permalink_path :slug => e.permalink
      end
    end

    def blog_entry_url_permalink(e)
      unless e.published_at.nil?
        blog_entry_permalink_url :year => e.published_at.strftime("%Y"), :month => e.published_at.strftime("%m"), :day => e.published_at.strftime("%d"), :slug => e.permalink
      else
        blog_entry_permalink_url :year => "na", :month => "na", :day => "na", :slug => e.permalink
      end
    end

    def blog_full_article_html(blog_entry)
      "<br><br>Read the full article #{link_to blog_entry.title, blog_entry_url_permalink(blog_entry)} at #{link_to "#{Spree::Config[:site_name]} Blog", blog_url}."
    end

    def blog_first_appeared_html(blog_entry)
      "<br><br>The article #{link_to blog_entry.title, blog_entry_url_permalink(blog_entry)} first appeared on #{link_to "#{Spree::Config[:site_name]} Blog", blog_url}."
    end

    def blog_entry_tag_list_html blog_entry
      blog_entry.blog_tags.map {|tag| link_to tag.name, blog_tag_path(tag.slug(locale: I18n.locale)) }.join(", ").html_safe
    end

    def blog_entry_category_list_html blog_entry
      blog_entry.genres.map {|category| link_to category.name, blog_category_path(category.slug(locale: I18n.locale)) }.join(", ").html_safe
    end

    def tag_cloud(tags, classes)
      return [] if tags.blank?
      max_count = tags.sort_by(&:count).last.count.to_f
      tags.each do |tag|
        index = ((tag.count / max_count) * (classes.size - 1))
        yield tag, classes[index.nan? ? 0 : index.round]
      end
    end

    def set_locales_array
      begin
        loc = SpreeI18n::Config.available_locales  
        x = loc.delete(I18n.locale)
        loc.unshift(x)
      rescue  
        loc = ['pl']
      end 
    end
    def show_project  entry 
      if entry.project
        content_tag(:i, '', :class => 'glyphicon glyphicon-check')
      else
        content_tag(:i, '', :class => 'glyphicon glyphicon-unchecked')
      end
    end
    def show_visibility entry 
      if entry.visible
        content_tag(:i, '', :class => 'glyphicon glyphicon-check')
      else
        content_tag(:i, '', :class => 'glyphicon glyphicon-unchecked')
      end
    end

    def set_header_title
      if request.path_info.include?('blog')
        content_tag :h1, t(:blog)
      elsif request.path_info.include?('about')
        content_tag :h1, t(:about)
      end
    end

  end
end
