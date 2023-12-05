module Org
  class MemberDepartment < ApplicationRecord
    include Model::MemberDepartment
    include Notice::Ext::MemberDepartment if defined? RailsNotice
  end
end
