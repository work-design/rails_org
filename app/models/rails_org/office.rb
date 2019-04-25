module RailsOrg::Office
  extend ActiveSupport::Concern
  included do
    has_taxons :area

    attribute :name_short, :string
    belongs_to :area
    has_many :rooms, dependent: :destroy
    has_many :supports, -> { where(department_id: nil) }, dependent: :destroy
    has_many :members, dependent: :nullify

    has_many :member_job_titles
    has_many :leaders, through: :member_job_titles, source: :member
    has_one :member_job_title, -> { order(grade: :desc) }
    has_one :leader, through: :member_job_title, source: :member

    validates :name, presence: true
  end

  def enabled_members_count
    Member.where(office: self).where(enabled: true).count
  end

end
