class JobTransfer < ApplicationRecord
  include RailsOrg::JobTransfer
  include RailsAudit::CheckMachine
end unless defined? JobTransfer
