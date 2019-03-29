class JobTitle < ApplicationRecord
  acts_as_list column: :grade, scope: [:department_id, :office_id], top_of_list: 0, add_new_at: :top

  attribute :name, :string
  attribute :grade, :integer, default: 0

  belongs_to :department, optional: true
  belongs_to :office, optional: true
  has_many :member_job_titles, ->(o){ default_where('grade-lte': o.grade) }

end
