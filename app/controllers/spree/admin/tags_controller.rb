class Spree::Admin::TagsController < Spree::Admin::ResourceController
  helper 'spree/blog_entries'
  before_action :tag_attributes, only: [:create, :update]
  def index
    @tags = Spree::Tag.all
    @tag = Spree::Tag.new
  end

  def edit
    @tags = Spree::Tag.all
    @tag = Spree::Tag.find(params[:id])
  end
  
  def update
    @tag = Spree::Tag.find(params[:id])
    @tag.attributes = set_params
    if @tag.save
      flash[:success] = flash_message_for(@tag, :successfully_updated)
    else
      flash[:error] = flash_message_for(@tag, :not_updated)
    end
    redirect_to admin_tags_url
  end

  def create
    @tag = Spree::Tag.new
    @tag.attributes = set_params
    if @tag.save
      flash[:success] = flash_message_for(@tag, :successfully_created)
    else
      flash[:error] = flash_message_for(@tag, :not_created)
    end
    redirect_to admin_tags_url
  end

  def destroy
    @tag = Spree::Tag.find(params[:id])
    @tag.delete
    flash[:success] = flash_message_for(@tag, :successfully_removed)
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
