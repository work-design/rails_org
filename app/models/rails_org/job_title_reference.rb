module RailsOrg::JobTitleReference
  extend ActiveSupport::Concern

  included do
    attribute :grade, :integer

    belongs_to :super_job_title
    belongs_to :department
    belongs_to :department_root, class_name: 'Department'
    has_many :department_job_titles, ->(o){ default_where('grade-gte': o.grade) }, foreign_key: :department_root_id, primary_key: :department_root_id

    after_initialize if: :new_record? do
      if department
        self.department_root = department.root
      end
      self.grade = super_job_title.grade
    end
    after_commit :sync_to_member_departments, on: [:create, :destroy]
  end

  def sync_to_member_departments

  end

end
