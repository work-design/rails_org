class Department < ApplicationRecord
  prepend RailsTaxon::Node
  include RailsOrg::Department
  DepartmentHierarchy.include RailsOrg::DepartmentHierarchy
end unless defined? Department
