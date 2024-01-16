class OauthCallbacksController < Devise::OauthCallbacksController
  def github
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user&.pesisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :succes, kind: 'Github') if is_navigational_format?
    else
      redirect_to root_path, alert: "Something went wrong"
    end
  end
end
