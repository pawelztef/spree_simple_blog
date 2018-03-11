class Spree::Admin::LabelsController < Spree::Admin::ResourceController
  helper 'spree/blog_entries'
  before_action :labels_attributes, only: [:create, :update]
  def index
    @labels = Spree::Label.all
    @label = Spree::Label.new
  end

  def edit
    @labels = Spree::Label.all
    @label = Spree::Label.find(params[:id])
  end

  def update
    @label = Spree::Label.find(params[:id])
    @label.attributes = set_params
    if @label.save
      flash[:success] = flash_message_for(@label, :successfully_updated)
    else
      flash[:error] = flash_message_for(@label, :not_updated)
    end
    redirect_to admin_labels_url
  end

  def create
    @label = Spree::Label.new
    @label.attributes = set_params
    if @label.save
      flash[:success] = flash_message_for(@label, :successfully_created)
    else
      flash[:error] = flash_message_for(@label, :not_created)
    end
    redirect_to admin_labels_url
  end

  def destroy
    @label = Spree::Label.find(params[:id])
    @label.delete
    flash[:success] = flash_message_for(@label, :successfully_removed)
    redirect_to admin_labels_url
  end

  private
  def set_params
    labels_attributes.merge( Hash[labels_attributes.to_h.map { |k, v| [k.sub('name', 'slug'), v.parameterize] }])
  end

  def labels_attributes
    params.require(:label).permit!
  end
end
