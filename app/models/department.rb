class Department < ApplicationRecord
  include Com::Ext::Taxon
  include RailsOrg::Department
  DepartmentHierarchy.include RailsOrg::DepartmentHierarchy
end unless defined? Department
