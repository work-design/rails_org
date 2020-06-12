module RailsOrg::MemberSuper
  extend ActiveSupport::Concern

  included do
    attribute :grade, :integer, default: 0

    belongs_to :member
    belongs_to :super_job_title
  end

  def xx
    self.grade = super_job_title.grade
  end

  def super_job_title_options
    SuperJobTitle.all
  end

end
