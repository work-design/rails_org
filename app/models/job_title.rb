class JobTitle < ApplicationRecord
  include RailsRole::User if defined? RailsRole # must included before RailsOrg::JobTitle
  include RailsOrg::JobTitle
end unless defined? JobTitle
