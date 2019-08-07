class Org::OrgansController < ApplicationController
  before_action :set_organ, only: [:show]
  
  def index
    q_params = { parent_id: nil }
    
    @organs = Organ.default_where(q_params, parent_id: { allow: nil }).order(id: :desc).page(params[:page])
  end
  
  def show
  end

  private
  def set_organ
    @organ = Organ.find params[:id]
  end

end
