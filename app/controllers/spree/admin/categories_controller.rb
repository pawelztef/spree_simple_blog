class Spree::Admin::CategoriesController < Spree::Admin::ResourceController
  helper 'spree/blog_entries'
  helper 'spree/admin/categories'

  def index
    @categories = Spree::Category.all
    @category = Spree::Category.new
  end

  def create

  end

  def delete

  end

  private

  def cat_attributes

  end
end
