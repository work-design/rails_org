class Department < ApplicationRecord
  include RailsOrg::Department
end unless defined? Department
