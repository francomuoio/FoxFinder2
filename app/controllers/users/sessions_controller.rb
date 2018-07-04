class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  include Accessible
 skip_before_action :check_user, only: :destroy

  # GET /resource/sign_in
  def new
    if company_signed_in?
      redirect_to root_path, alert: "Vous êtes déja connecté en tant qu'Agence."
    end
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
      if user_signed_in?
        super
      else
        redirect_to root_path, alert: "Vous n'êtes pas autorisé à acceder à ce lien."
      end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
