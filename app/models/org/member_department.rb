module Org
  class MemberDepartment < ApplicationRecord
    include Model::MemberDepartment
    include Notice::Model::MemberDepartment
  end
end
