class Org::Mine::OrgansController < Org::Mine::BaseController
  before_action :set_organ, only: [:show, :edit, :update, :destroy]

  def index
    @organs = current_user.organs.distinct.page(params[:page])
    session.delete :organ_token
  end

  def new
    @member = current_user.members.build
    @organ = @member.build_organ
  end

  def create
    parent_uuid = params.dig(:member, :parent_uuid)
    if parent_uuid.present?
      parent = Organ.find_by organ_uuid: parent_uuid
      organ_params.merge! parent_id: parent.id
    end
    @member = current_user.members.build(member_params)
    @member.build_organ(organ_params)

    respond_to do |format|
      if @member.save
        format.html.phone
        format.html { redirect_to my_organs_url }
        format.js
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @organ.update(organ_params)
      redirect_to admin_organs_url
    else
      render :edit
    end
  end

  def destroy
    @organ.destroy
    redirect_to admin_organs_url
  end

  private
  def set_member
    @member = current_user.members.find params[:member_id]
  end
  
  def set_organ
    @organ = Organ.find(params[:id])
  end
  
  def member_params
    p = params.fetch(:member, {}).permit(:identity)
    p.merge! owned: true
  end

  def organ_params
    params.fetch(:member, {}).fetch(:organ_attributes, {}).permit(
      :name,
      :logo
    )
  end

end
