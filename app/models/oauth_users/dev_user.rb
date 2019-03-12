class DevUser < OauthUser


  def save_info(info_params)
    self.provider = 'developer'
  end

end
