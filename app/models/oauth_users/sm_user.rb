class SmUser < OauthUser

  def save_info(info_params)
    credentials = info_params.fetch('credentials', {})

    self.provider = 'surveymonkey'
    self.access_token = credentials['token']
  end

  def oauth_client(scope = [])
    return @oauth_client if @oauth_client
    oauth = OmniAuth::Strategies::MicrosoftV2Auth.new(
      nil, # App - nil seems to be ok?!
      SETTING['sm_client_id'],
      SETTING['sm_client_secret'],
      scope: []
    )
    @oauth_client = oauth.client
    @oauth_client.site = 'https://api.surveymonkey.com/v3'
    @oauth_client.options[:raise_errors] = false
    @oauth_client
  end

  def access_client
    @access_client ||= OAuth2::AccessToken.new oauth_client, self.access_token
  end

end
