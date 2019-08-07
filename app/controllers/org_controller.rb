class OrgController < MyController
  include RailsOrg::OrgController
end unless defined? OrgController
