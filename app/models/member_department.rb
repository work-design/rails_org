class MemberDepartment < ApplicationRecord
  include RailsOrg::MemberDepartment
  include RailsNotice::MemberDepartment
end unless defined? MemberDepartment
