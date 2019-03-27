class JobTitle < ApplicationRecord
  acts_as_list column: :grade, scope: :department_id, top_of_list: 0, add_new_at: :top

  attribute :name, :string
  attribute :grade, :integer, default: 0

  belongs_to :department

end
