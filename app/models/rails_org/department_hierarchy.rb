module RailsOrg::DepartmentHierarchy
  extend ActiveSupport::Concern
  included do
    belongs_to :member_department, foreign_key: :descendant_id, primary_key: :department_id, optional: true
  end
  
end
