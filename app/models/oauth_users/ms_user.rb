class MsUser < OauthUser

  def save_info(info_params)
    credentials = info_params.fetch('credentials', {})

    self.provider = 'microsoft_v2_auth'
    self.access_token = credentials['token']
    self.expires_at = Time.at credentials['expires_at'].to_i
  end

  def oauth_client(scope = [])
    return @oauth_client if @oauth_client
    oauth = OmniAuth::Strategies::MicrosoftV2Auth.new(
      nil, # App - nil seems to be ok?!
      SETTING['ms_client_id'],
      SETTING['ms_client_secret'],
      scope: []
    )
    @oauth_client = oauth.client
    @oauth_client.site = 'https://graph.microsoft.com/v1.0/'
    @oauth_client.options[:raise_errors] = false
    @oauth_client
  end

  def one_drive
    @one_drive ||= OAuth2::AccessToken.new oauth_client, self.access_token
  end

end
