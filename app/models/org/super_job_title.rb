module Org
  class SuperJobTitle < ApplicationRecord
    include Roled::Model::User if defined? RailsRole # must included before RailsOrg::SuperJobTitle
    include Model::SuperJobTitle
  end
end
