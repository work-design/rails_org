class JobTitle < ApplicationRecord
  include RailsRole::User # must included before RailsOrg::JobTitle
  include RailsOrg::JobTitle
end unless defined? JobTitle
