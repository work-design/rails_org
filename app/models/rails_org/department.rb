module RailsOrg::Department
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :needed_number, :integer, default: 1
    attribute :member_departments_count, :integer, default: 0
    attribute :all_member_departments_count, :integer, default: 0

    belongs_to :organ, optional: true
    belongs_to :superior, class_name: self.name, optional: true
    has_many :inferiors, class_name: self.name, foreign_key: :superior_id

    has_many :job_descriptions
    has_many :job_titles
    has_many :all_job_titles, class_name: 'JobTitle', foreign_key: :department_root_id

    has_many :member_departments, dependent: :delete_all
    has_many :members, through: :member_departments, source: :member
    has_many :organs, -> { distinct }, through: :member_departments

    has_one :member_department, -> { order(grade: :asc) }
    has_one :leader, through: :member_department, source: :member

    has_one_attached :logo
    has_taxons :superior
    validates :name, presence: true, uniqueness: { scope: [:superior_id, :organ_id] }
  end

  def all_members
    ids = MemberDepartment.default_where(department_id: self.self_and_descendant_ids).pluck(:member_id)
    Member.where(id: ids)
  end

  def col_span
    self.class.max_depth - self.depth
  end

  def names
    self_and_ancestors.pluck(:name).reverse
  end

  def full_name
    names.join(' > ')
  end

  def supports
    return @supports if @supports
    results = Support.where(department_id: self.self_and_ancestor_ids).group_by { |i| i.kind }
    @supports = results.map do |_, records|
      records.sort_by! { |i| self.self_and_ancestor_ids.index(i.department_id) }.first
    end
  end

  def reset_all_member_departments_count
    update(all_member_departments_count: self_and_descendants.sum(:member_departments_count))
  end

  class_methods do
    def filter_options
      Department.leaves.map { |i| [i.full_name, i.id] }
    end
  end

end
