class Spree::BlogEntriesController < Spree::StoreController
  helper 'spree/blog_entries'

  before_action :init_pagination, :only => [:all, :index, :tag, :archive, :author, :category, :about]
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def about
    @title = Spree.t(:about)
    @me = Spree::Me.first
    @blog_entries = Spree::BlogEntry.visible.project.page(params[:page]).per(@pagination_per_page)
  end

  def project
    @blog_entry = Spree::BlogEntry.find_by_permalink!(params[:slug])
  end

  def index
    @title = Spree.t(:blog)
    @blog_entries = Spree::Genre.all.map { |g| g.blog_entries.first }
    @blog_entries =  @blog_entries.compact.uniq { |e| e.title }
    if @blog_entries.empty?
      @blog_entries = Spree::BlogEntry.visible.page(params[:page]).per(@pagination_per_page)
    else
      @blog_entries = Kaminari.paginate_array(@blog_entries).page(params[:page]).per(@pagination_per_page)
    end
    @categories = @blog_entries.map { |e| e.genres }
    @categories = @categories.flatten.uniq { |c| c.name }
  end

  def show
    @blog_entry = Spree::BlogEntry.find_by_permalink!(params[:slug])
    @title = @blog_entry.title
  end

  def tag
    @blog_entries = Spree::BlogEntry.visible.by_label(params[:tag]).page(params[:page]).per(@pagination_per_page)
    @tag_name = Spree::Label.i18n.find_by_slug(params[:tag]).name
  end

  def category
    @blog_entries = Spree::BlogEntry.visible.by_category(params[:category]).page(params[:page]).per(@pagination_per_page)
    @category_name = Spree::Genre.i18n.find_by_slug(params[:category]).name
  end

  def archive
    @blog_entries = Spree::BlogEntry.visible.by_date(params).page(params[:page]).per(@pagination_per_page)
  end

  def feed
    @blog_entries = Spree::BlogEntry.visible.limit(20)
    render :layout => false
  end

  def author
    @author = Spree.user_class.where(:nickname => params[:author]).first
    @blog_entries = Spree::BlogEntry.visible.by_author(@author).page(params[:page]).per(@pagination_per_page)
  end

  def all
    @blog_entries = Spree::BlogEntry.visible.not_project.all.page(params[:page]).per(@pagination_per_page)
  end

  private

  def init_pagination
    @pagination_per_page = 9
  end
end
