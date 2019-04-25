class User < ApplicationRecord
  include RailsOrg::User
end unless defined? User
