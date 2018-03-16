module Spree::Admin::MesHelper
  def set_locales_array
    begin
      loc = SpreeI18n::Config.available_locales  
      x = loc.delete(I18n.locale)
      loc.unshift(x)
    rescue  
      loc = ['pl']
    end 
  end
end
