module RailsOrg::Department
  extend ActiveSupport::Concern
  included do
    belongs_to :office, optional: true
    
    has_many :job_descriptions
    has_many :job_titles
    has_many :member_departments, dependent: :delete_all
    has_many :members, through: :member_departments, source: :member
    has_many :offices, -> { distinct }, through: :member_departments
    
    has_one :member_department, -> { order(grade: :desc) }
    has_one :leader, through: :member_department, source: :member
    
    has_one_attached :logo
    
    validates :name, presence: true
    after_save_commit :sync_descendant_tree, if: -> { saved_change_member_departments_count? }
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

  def sync_descendant_tree
    self.self_and_ancestors.each do |depart|
      depart.update(all_member_departments_count: depart.self_and_descendants.sum(:member_departments_count))
    end
  end
  
  class_methods do
    def filter_options
      Department.leaves.map { |i| [i.full_name, i.id] }
    end
  end

end
