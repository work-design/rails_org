class OrganToken < ApplicationRecord
  include RailsOrg::OrganToken
end unless defined? OrganToken
