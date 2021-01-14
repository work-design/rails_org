module Org
  class Department < ApplicationRecord
    include Com::Ext::Taxon
    include Model::Department
    DepartmentHierarchy.include RailsOrg::DepartmentHierarchy
  end
end
