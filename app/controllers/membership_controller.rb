class MembershipController < MyController
  include RailsOrg::Application
  before_action :require_member
  
end unless defined? MembershipController
