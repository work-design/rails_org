class Office < ApplicationRecord
  attribute :lunch_time, :string, default: '12:30'
  belongs_to :leader, class_name: 'Member', optional: true
  belongs_to :deputy_leader, class_name: 'Member', optional: true
  has_many :supports, -> { where(department_id: nil) }, dependent: :destroy
  has_many :members, dependent: :nullify

  validates :name, presence: true


  def enabled_members_count
    Member.where(office: self).where(enabled: true).count
  end

  def self.colors
    ['red', 'blue', 'orange', 'green', 'yellow', 'black', 'pink', 'purple', 'gray']
  end

  def self.countries
    SETTING['countries'].map { |i| [i, i] }
  end

end
