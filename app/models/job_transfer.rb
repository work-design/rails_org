class JobTransfer < ApplicationRecord
  include RailsOrg::JobTransfer
  include RailsAudit::CheckMachine if defined? RailsAudit
end unless defined? JobTransfer
