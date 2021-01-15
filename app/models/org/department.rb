module Org
  class Department < ApplicationRecord
    include Com::Ext::Taxon
    include Model::Department
  end
end
