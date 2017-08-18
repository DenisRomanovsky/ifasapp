class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_in_path_for(resource)
    if resource.has_info?
      root_path
    else
      edit_profile_path
    end
  end
end