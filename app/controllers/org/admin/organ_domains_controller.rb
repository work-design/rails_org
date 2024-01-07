module Org
  class Admin::OrganDomainsController < Panel::OrganDomainsController
    #include Org::Layout::Panel

    private
    def set_organ
      @organ = current_organ.self_and_descendants.find params[:organ_id]
    end
  end
end
