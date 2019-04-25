class JobDescription < ApplicationRecord
  include RailsOrg::JobDescription
end unless defined? JobDescription
