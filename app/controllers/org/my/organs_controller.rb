class Org::My::OrgansController < Org::My::BaseController
  before_action :set_organ, only: [:show, :edit, :update, :destroy]

  def index
    @organs = current_user.created_organs.page(params[:page])
  end

  def new
    @organ = current_user.created_organs.build
    @organ.members.build
  end

  def create
    parent_uuid = params.dig(:organ, :parent_uuid)
    if parent_uuid.present?
      parent = Organ.find_by organ_uuid: parent_uuid
      organ_params.merge! parent_id: parent.id
    end
    @organ = current_user.created_organs.build(organ_params)
    @organ.members.each { |i| i.user = current_user }

    respond_to do |format|
      if @organ.save
        format.html.phone
        format.html { redirect_to my_members_url }
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

  def organ_params
    params.fetch(:organ, {}).permit(
      :name,
      :logo,
      :name_short,
      :address,
      :timezone,
      :locale,
      :area_ancestors,
      members_attributes: {}
    )
  end

end
