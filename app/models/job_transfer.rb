class JobTransfer < ApplicationRecord
  include RailsOrg::JobTransfer
end unless defined? JobTransfer
