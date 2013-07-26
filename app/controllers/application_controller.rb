class ApplicationController < ActionController::Base
  protect_from_forgery
  include ApplicationHelper
  layout :get_layout

  def get_layout
    if params[:controller] == 'home'
      return "about"
    elsif params[:controller] == 'businesses' and params[:action] == 'index'
      return "search"
    else
      return "application"
    end
    
  end
end
