module Org
  class MemberDepartment < ApplicationRecord
    include Model::MemberDepartment
    include RailsNotice::MemberDepartment
  end
end
