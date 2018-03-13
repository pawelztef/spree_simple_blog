class Spree::Admin::BlogEntriesController < Spree::Admin::ResourceController
  helper 'spree/blog_entries'
  before_action :set_mobility

  def index
    @blog_entries = Spree::BlogEntry.all.page(params[:page]).per(9)
  end

  def new
    Spree::BlogEntry.new
  end

  def edit
    @blog_entry = Spree::BlogEntry.find(params[:id])
  end

  def update
    @blog_entry = Spree::BlogEntry.find(params[:id])
    @blog_entry.assign_attributes(entry_params)
    @blog_entry.create_permalink
    if @blog_entry.save
      flash[:success] = flash_message_for(@blog_entry, :successfully_updated)
      redirect_to admin_blog_entries_url
    else
      render :new
    end
  end

  def mobility
    session[:mobility_locale] = params[:mobility_locale]
    redirect_to admin_blog_entries_url 
  end

  def create
    @blog_entry = Spree::BlogEntry.new(entry_params)
    @blog_entry.create_permalink
    if @blog_entry.save
      flash[:success] = flash_message_for(@blog_entry, :successfully_created)
      redirect_to admin_blog_entries_url
    else
      # flash[:error] = flash_message_for(@blog_entry, :not_created)
      render :new
    end
  end

  private

  def location_after_save
    edit_admin_blog_entry_url(@blog_entry)
  end

  def collection
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 20
    model_class.page(page).per(per_page)
  end

  def entry_params
    params.require(:blog_entry).permit!
  end

  def set_mobility
    if session[:mobility_locale]
      Mobility.locale = session[:mobility_locale]
    end
  end


end
