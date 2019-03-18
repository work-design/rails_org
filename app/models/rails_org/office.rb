class Office < ApplicationRecord
  has_taxons :area

  attribute :name_short, :string
  belongs_to :area, optional: true
  has_many :rooms, dependent: :destroy
  has_many :supports, -> { where(department_id: nil) }, dependent: :destroy
  has_many :members, dependent: :nullify

  validates :name, presence: true

  def enabled_members_count
    Member.where(office: self).where(enabled: true).count
  end

end
