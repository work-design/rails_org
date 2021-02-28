module Org
  module Model::SuperJobTitle
    extend ActiveSupport::Concern

    included do
      attribute :grade, :integer
      attribute :name, :string
      attribute :description, :string

      belongs_to :organ, optional: true
      has_many :job_titles, dependent: :destroy

      default_scope -> { order(grade: :asc) }

      after_update_commit :sync_grade_member_departments, if: -> { saved_change_to_grade? }

      acts_as_list column: :grade, scope: :organ_id
    end

    def sync_grade_member_departments
      job_titles.update_all(name: name)
    end

  end
end
