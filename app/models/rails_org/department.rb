class Department < ApplicationRecord
  prepend RailsTaxonNode
  belongs_to :leader, class_name: 'Member', optional: true
  has_many :job_descriptions
  has_many :members, dependent: :nullify
  has_many :offices, -> { distinct }, through: :members
  has_many :lesson_grants, -> (department){ unscope(where: :department_id).where(department_id: department.self_and_ancestor_ids) }, dependent: :nullify
  has_many :lessons, through: :lesson_grants

  validates :name, presence: true
  #validates :leader_id, presence: true
  #validates :members_count, numericality: { greater_than: 0 }

  after_save :sync_type, if: -> { saved_change_to_type? }
  after_save :sync_night_shift, if: -> { saved_change_to_night_shift? }

  default_scope -> { where(enabled: true) }
  scope :sections, -> { where(enabled: true, kind: :section) }
  scope :groups, -> { where(enabled: true, kind: :grouping) }

  enum kind: {
    section: 'section',
    grouping: 'grouping'
  }

  def leader_member
    Member.find(self.leader_id) if self.leader_id
  end

  SUPPORTS = Support.kinds.keys & ['editorial', 'hr', 'financial', 'marketing']

  def sync_type
    self.descendants.update_all type: self.type
  end

  def sync_night_shift
    self.descendants.update_all night_shift: self.night_shift
  end

  def col_span
    self.class.max_depth - self.depth
  end

  # todo cache in db
  def all_members_count
    self.self_and_descendants.sum(:members_count)
  end

  def full_name
    self_and_ancestors.pluck(:name).reverse.join(' > ')
  end

  def all_job_titles
    JobTitle.where(department_id: self.self_and_ancestor_ids)
  end

  def supports
    return @supports if @supports
    results = Support.where(department_id: self.self_and_ancestor_ids).group_by { |i| i.kind }
    @supports = results.map do |_, records|
      records.sort_by! { |i| self.self_and_ancestor_ids.index(i.department_id) }.first
    end
  end

  Support.kinds.keys.each do |role|
    define_method("#{role}") do
      supports.find { |i| i.kind == role.to_s }&.supporter
    end
  end

  def self.filter_options
    Department.leaves.map { |i| [i.full_name, i.id] }
  end

end
