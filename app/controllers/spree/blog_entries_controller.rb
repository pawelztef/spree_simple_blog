class Spree::BlogEntriesController < Spree::StoreController
  helper 'spree/blog_entries'

  before_action :init_pagination, :only => [:index, :tag, :archive, :author, :category, :about]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def about
    @blog_entries = Spree::BlogEntry.visible.project.page(@pagination_page).per(@pagination_per_page)
  end

  def project
    @blog_entry = Spree::BlogEntry.find_by_permalink!(params[:slug])
  end

  def index
    @categories = Spree::Genre.all
    # @blog_entries = @categories.map { |cat| cat.blog_entries.first }
    # @blog_entries = Spree::BlogEntry.visible.where(project: false).page(@pagination_page).per(@pagination_per_page)
    @blog_entries = Spree::BlogEntry.visible.all
  end

  def show
    @blog_entry = Spree::BlogEntry.find_by_permalink!(params[:slug])
    @title = @blog_entry.title
  end

  def tag
    @blog_entries = Spree::BlogEntry.visible.by_tag(params[:tag]).page(@pagination_page).per(@pagination_per_page)
    @tag_name = params[:tag]
  end

  def category
    @blog_entries = Spree::BlogEntry.visible.by_category(params[:category]).page(@pagination_page).per(@pagination_per_page)
    @category_name = params[:category]
  end

  def archive
    @blog_entries = Spree::BlogEntry.visible.by_date(params).page(@pagination_page).per(@pagination_per_page)
  end

  def feed
    @blog_entries = Spree::BlogEntry.visible.limit(20)
    render :layout => false
  end

  def author
    @author = Spree.user_class.where(:nickname => params[:author]).first
    @blog_entries = Spree::BlogEntry.visible.by_author(@author).page(@pagination_page).per(@pagination_per_page)
  end

  private

  def init_pagination
    @pagination_page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @pagination_per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10
  end
end
