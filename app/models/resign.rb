class Resign < ApplicationRecord
  include RailsOrg::Resign
  include RailsAudit::CheckMachine
end unless defined? Resign
