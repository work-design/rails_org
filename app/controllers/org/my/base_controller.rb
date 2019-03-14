class Org::My::BaseController < RailsOrg.config.my_class.constantize


  def current_member
    current_user.members.first
  end


end
