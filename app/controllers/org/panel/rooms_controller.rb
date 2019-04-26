class Org::Panel::RoomsController < Org::Panel::BaseController
  before_action :set_office
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit(:room_number)
    @rooms = @office.rooms.default_where(q_params).page(params[:page])
  end

  def new
    @room = @office.rooms.build
  end

  def create
    @room = @office.rooms.build(room_params)

    respond_to do |format|
      if @room.save
        format.html.phone
        format.html { redirect_to panel_office_rooms_url(@office) }
        format.js { redirect_back fallback_location: panel_office_rooms_url(@office) }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: panel_office_rooms_url(@office) }
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
        format.html { redirect_to panel_office_rooms_url(@office) }
        format.js { redirect_back fallback_location: panel_office_rooms_url(@office) }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: panel_office_rooms_url(@office) }
        format.json { render :show }
      end
    end
  end

  def destroy
    @room.destroy
    redirect_to panel_office_rooms_url(@office)
  end

  private
  def set_office
    @office = Office.find params[:office_id]
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
