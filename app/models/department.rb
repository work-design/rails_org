class Department < ApplicationRecord
  prepend RailsTaxon::Node
  include RailsOrg::Department
end unless defined? Department
