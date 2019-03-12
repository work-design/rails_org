class OauthController < ApplicationController
  skip_before_action :verify_authenticity_token
  TYPE = {
    github: 'GithubUser',
    developer: 'DevUser',
    microsoft_v2_auth: 'MsUser',
    surveymonkey: 'SmUser'
  }

  def create
    @oauth_user = OauthUser.find_or_initialize_by(type: TYPE[oauth_params[:provider].to_sym], uid: oauth_params[:uid])
    @oauth_user.save_info(oauth_params)

    if current_user
      @oauth_user.user = current_user

      redirect_to my_oauth_users_url, notice: 'Oauth user created successfully' if @oauth_user.save
    else
      @oauth_user.init_user

      redirect_to(oauth_users_path, notice: 'Oauth user created successfully') if @oauth_user.save
    end
  end

  def failure
    redirect_to root_url, alert: "Error: #{params[:message].humanize}"
  end

  private
  def oauth_params
    request.env['omniauth.auth']
  end

end
