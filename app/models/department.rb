class Department < ApplicationRecord
  include RailsCom::Taxon
  include RailsOrg::Department
  DepartmentHierarchy.include RailsOrg::DepartmentHierarchy
end unless defined? Department
