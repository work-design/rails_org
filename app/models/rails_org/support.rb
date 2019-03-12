class Support < ApplicationRecord
  attr_accessor :department_ancestors

  belongs_to :member, optional: true
  belongs_to :department, optional: true
  belongs_to :office, optional: true
  belongs_to :supporter, class_name: 'Member'

  validates :kind, uniqueness: { scope: [:department_id, :office_id] }

  enum kind: {
    editorial: 'editorial',
    hr: 'hr',
    financial: 'financial',
    second_financial: 'second_financial',
    cashier: 'cashier',
    accountant: 'accountant',
    marketing: 'marketing',
    layout: 'layout',
    it: 'it',
    admin: 'admin',
    leader: 'leader'
  }

end