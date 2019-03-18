class Org::Panel::RoomsController < Org::Panel::BaseController
  before_action :set_office
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = @office.rooms.page(params[:page])
  end

  def new
    @room = @office.rooms.build
  end

  def create
    @room = @office.rooms.build(room_params)

    respond_to do |format|
      if @room.save
        format.html.phone
        format.html { redirect_to panel_office_rooms_url(@office), notice: 'Room was successfully created.' }
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
        format.html { redirect_to panel_office_rooms_url(@office), notice: 'Room was successfully updated.' }
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
    redirect_to panel_office_rooms_url(@office), notice: 'Room was successfully destroyed.'
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
      :time_plans_count
    )
  end

end
