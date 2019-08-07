class Org::OrgansController < ApplicationController
  include RailsOrg::OrgController
  before_action :set_organ, only: [:show, :login]
  
  def index
    q_params = { parent_id: nil }
    
    @organs = Organ.default_where(q_params, parent_id: { allow: nil }).order(id: :desc).page(params[:page])
  end
  
  def show
  end
  
  def login
    organ_token = @organ.get_organ_token(current_user)
    login_organ_as organ_token
  
    respond_to do |format|
      format.html { redirect_to organ_url(@organ) }
      format.json { render json: { organ_grant: organ_grant } }
    end
  end

  private
  def set_organ
    @organ = Organ.find params[:id]
  end

end
