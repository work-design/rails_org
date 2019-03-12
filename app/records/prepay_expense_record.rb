module PrepayExpenseRecord
  extend TheData::Record

  config do
    object ->(params){ ExpenseMember.default_where(params).take }
    column :department, field: ->(o){ o.member.department.full_name }
    column :company, field: ->(o){ o.member.office.company_name }
    column :create_at, field: ->(o){ o.created_at.to_s }
    column :subject, field: ->(o){ o.subject }
    column :note, field: ->(o){ o.note }
    column :amount_cn, field: ->(o) { o.amount_cn }
    column :amount, field: ->(o) { o.amount }
    column :invoices_count, field: ->(o) { o.invoices_count }
  end

end
