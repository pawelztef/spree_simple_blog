class Spree::Admin::BlogTagsController < Spree::Admin::ResourceController
  helper 'spree/blog_entries'
  before_action :tag_attributes, only: [:create, :update]
  def index
    @blog_tags = Spree::BlogTag.all
    @blog_tag = Spree::BlogTag.new
  end

  def edit
    @blog_tags = Spree::BlogTag.all
    @blog_tag = Spree::BlogTag.find(params[:id])
  end
  
  def update
    @blog_tag = Spree::BlogTag.find(params[:id])
    @blog_tag.attributes = set_params
    if @blog_tag.save
      flash[:success] = flash_message_for(@blog_tag, :successfully_updated)
    else
      flash[:error] = flash_message_for(@blog_tag, :not_updated)
    end
    redirect_to admin_tags_url
  end

  def create
    @blog_tag = Spree::BlogTag.new
    @blog_tag.attributes = set_params
    if @blog_tag.save
      flash[:success] = flash_message_for(@blog_tag, :successfully_created)
    else
      flash[:error] = flash_message_for(@blog_tag, :not_created)
    end
    redirect_to admin_tags_url
  end

  def destroy
    @blog_tag = Spree::BlogTag.find(params[:id])
    @blog_tag.delete
    flash[:success] = flash_message_for(@blog_tag, :successfully_removed)
    redirect_to admin_tags_url
  end

  private
  def set_params
    tag_attributes.merge( Hash[tag_attributes.to_h.map { |k, v| [k.sub('name', 'slug'), v.parameterize] }])
  end

  def tag_attributes
    params.require(:tag).permit!
  end
end
