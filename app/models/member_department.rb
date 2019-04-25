class MemberDepartment < ApplicationRecord
  include RailsOrg::MemberDepartment
end unless defined? MemberDepartment
