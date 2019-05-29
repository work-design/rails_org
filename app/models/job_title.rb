class JobTitle < ApplicationRecord
  include RailsRole::User # must included before Rails::JobTitle
  include RailsOrg::JobTitle
end unless defined? JobTitle
