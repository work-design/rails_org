module RailsOrg::JobTitle
  extend ActiveSupport::Concern
  included do
    attribute :grade, :integer, default: 0
    attribute :name, :string
    attribute :description, :string
    attribute :limit_number, :integer

    belongs_to :department, optional: true
    belongs_to :department_root, class_name: 'Department', optional: true
    has_many :member_departments, dependent: :destroy
    
    default_scope -> { order(grade: :asc) }
    
    before_validation do
      self.department_root = self.department&.root
    end
    after_update_commit :sync_grade_member_departments, if: -> { saved_change_to_grade? }
    acts_as_list column: :grade, scope: [:department_root_id], top_of_list: self.top_of_list
  end
  
  def sync_grade_member_departments
    member_departments.update_all(grade: self.grade)
  end
  
  class_methods do
    
    def top_of_list
      self.where(department_id: nil).order(grade: :asc).first.grade + 1
    end
    
  end

end
