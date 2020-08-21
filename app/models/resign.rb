class Resign < ApplicationRecord
  include RailsOrg::Resign
  include RailsAudit::CheckMachine if defined? RailsAudit
end unless defined? Resign
