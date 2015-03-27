class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    memories_path
  end
end
