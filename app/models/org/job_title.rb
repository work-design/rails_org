module Org
  class JobTitle < ApplicationRecord
    include Roled::Ext::JobTitle if defined? RailsRole # must included before RailsOrg::JobTitle
    include Model::JobTitle
  end
end
