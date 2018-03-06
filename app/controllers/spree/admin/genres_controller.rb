class Spree::Admin::GenresController < Spree::Admin::ResourceController
  helper 'spree/blog_entries'
  helper 'spree/admin/taggable'
  before_action :genre_attributes, only: [:create, :update]

  def index
    @genres = Spree::Genre.all
    @genre = Spree::Genre.new
  end

  def edit
    @genres = Spree::Genre.all
    @genre = Spree::Genre.find(params[:id])
  end
  
  def update
    @genre = Spree::Genre.find(params[:id])
    @genre.attributes = params[:genre]
    if @genre.save
      flash[:success] = flash_message_for(@genre, :successfully_updated)
    else
      flash[:error] = flash_message_for(@genre, :not_updated)
    end
    redirect_to admin_genres_url
  end

  def create
    @genre = Spree::Genre.new
    @genre.attributes = params[:genre]
    if @genre.save
      flash[:success] = flash_message_for(@genre, :successfully_created)
    else
      flash[:error] = flash_message_for(@genre, :not_created)
    end
    redirect_to admin_genres_url
  end

  def destroy
    @genre = Spree::Genre.find(params[:id])
    @genre.delete
    flash[:success] = flash_message_for(@genre, :successfully_removed)
    redirect_to admin_genres_url
  end

  private

  def genre_attributes
    params.require(:genre).permit!
  end
end
