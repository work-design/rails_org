class JobTitle < ApplicationRecord
  include RailsOrg::JobTitle
  include RailsRole::User
end unless defined? JobTitle
