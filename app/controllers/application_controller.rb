class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_admin_locale
    I18n.locale = :ru
  end

  def after_inactive_sign_up_path_for(resource)
    edit_profile_path
  end
end
