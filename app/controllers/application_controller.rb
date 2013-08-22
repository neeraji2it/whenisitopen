class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :get_layout
  helper_method :after_sign_in_path_for


  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      import_imports_path
    end
  end

  def get_layout
    if params[:controller] == 'home'
      return "about"
    elsif params[:controller] == 'businesses' and params[:action] == 'index'
      return "search"
    elsif current_admin
      return "application"
    else
      return "application"
    end
    
  end
end
