module RailsOrg::JobTitle
  extend ActiveSupport::Concern
  included do
    attribute :grade, :integer
    attribute :name, :string
    attribute :description, :string
    attribute :limit_number, :integer

    belongs_to :department
    belongs_to :department_root, class_name: 'Department'
    has_many :member_departments, dependent: :destroy
    
    default_scope -> { order(grade: :desc) }
    
    after_initialize if: :new_record? do
      self.department_root = self.department.root if self.department
    end
    after_update_commit :sync_grade_member_departments, if: -> { saved_change_to_grade? }
  end

  def sync_grade_member_departments
    member_departments.update_all(grade: self.grade)
  end

end
