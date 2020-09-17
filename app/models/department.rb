class Department < ApplicationRecord
  include RailsTaxon::Node
  include RailsOrg::Department
  DepartmentHierarchy.include RailsOrg::DepartmentHierarchy
end unless defined? Department
