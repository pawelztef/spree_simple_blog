class Spree::Admin::BlogEntriesController < Spree::Admin::ResourceController
  helper 'spree/blog_entries'

  def new
    Spree::BlogEntry.new
  end

  def edit
  end

  def update

  end

  def create
    @entry = Spree::BlogEntry.new(entry_params)
    if @entry.save
      redirect_to admin_blog_entries_url
    else
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

end
