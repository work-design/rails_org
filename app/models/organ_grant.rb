class OrganGrant < ApplicationRecord
  include RailsOrg::OrganGrant
  include RailsRole::User
end unless defined? OrganGrant
