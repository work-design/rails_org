class Org::My::OrgansController < Org::My::BaseController
  before_action :set_member
  before_action :set_organ, only: [:show, :edit, :update, :destroy]

  def index
    @organs = Organ.page(params[:page])
  end

  def new
    @organ = @member.organs.build
  end

  def create
    if params[:parent_uuid]
      parent = Organ.find_by organ_uuid: params[:parent_uuid]
      organ_params.merge! parent_id: parent.id
    end
    @organ = @member.organs.build(organ_params)

    respond_to do |format|
      if @organ.save
        format.html { redirect_to my_members_url }
        format.html.phone
        format.js { redirect_to my_members_url }
        format.json { render :show }
      else
        format.html { render :new }
        format.html.phone { render :new }
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

  def organ_params
    params.fetch(:organ, {}).permit(
      :name,
      :logo,
      :name_short,
      :parent_uuid,
      :area_ancestors
    )
  end

end
