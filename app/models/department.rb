class Department < ApplicationRecord
  include RailsTaxon::Node
  include RailsOrg::Department
end unless defined? Department
