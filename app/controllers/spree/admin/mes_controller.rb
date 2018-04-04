class Spree::Admin::MesController < Spree::Admin::ResourceController

  before_action :set_mobility

  def index
    @me = Spree::Me.first_or_initialize
  end

  def create
    @me = Spree::Me.new(me_params)
    if @me.save
      flash[:success] = Spree.t(:successfully_created_bio)
      redirect_to admin_mes_url
    else
      flash[:error] =  @me.errors.full_messages.map{|o| o }.join("") 
      redirect_to admin_mes_url
    end
  end

  def update
    @me = Spree::Me.find(params[:id])
    if @me.update(me_params)
      flash[:success] = Spree.t(:successfully_created_bio)
      redirect_to admin_mes_url
    else
      flash[:error] =  @me.errors.full_messages.map{|o| o }.join("") 
      redirect_to admin_mes_url
    end
  end

  def mobility
    session[:mobility_locale] = params[:mobility_locale]
    redirect_to admin_mes_url
  end

  private
  def me_params
    params.require(:me).permit!
  end

  def set_mobility
    if session[:mobility_locale]
      Mobility.locale = session[:mobility_locale]
    end
  end

end
