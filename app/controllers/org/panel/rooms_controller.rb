class Org::Panel::RoomsController < Org::Panel::BaseController
  before_action :set_organ
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit(:room_number)
    @rooms = @organ.rooms.default_where(q_params).page(params[:page])
  end

  def new
    @room = @organ.rooms.build
  end

  def create
    @room = @organ.rooms.build(room_params)

    respond_to do |format|
      if @room.save
        format.html.phone
        format.html { redirect_to panel_organ_rooms_url(@organ) }
        format.js { redirect_back fallback_location: panel_organ_rooms_url(@organ) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: panel_organ_rooms_url(@organ) }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @room.assign_attributes(room_params)

    respond_to do |format|
      if @room.save
        format.html.phone
        format.html { redirect_to panel_organ_rooms_url(@organ) }
        format.js { redirect_back fallback_location: panel_organ_rooms_url(@organ) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: panel_organ_rooms_url(@organ) }
        format.json { render :show }
      end
    end
  end

  def destroy
    @room.destroy
    redirect_to panel_organ_rooms_url(@organ)
  end

  private
  def set_organ
    @organ = Organ.find params[:organ_id]
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.fetch(:room, {}).permit(
      :room_number,
      :color,
      :limit_number
    )
  end

end
