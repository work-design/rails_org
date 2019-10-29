FactoryBot.define do
  
  factory :department do
    name { 'MyString' }
    member_departments_count { 1 }
    all_member_departments_count { 1 }
    needed_number { 1 }
    parent_ancestors { {} }
    superior_ancestors { {} }
  end
  
end
