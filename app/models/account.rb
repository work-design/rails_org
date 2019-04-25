class Account < ApplicationRecord
  include RailsOrg::Account
end unless defined? Account
