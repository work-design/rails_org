class Org::Admin::RoomsController < Org::Admin::BaseController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:room_number)
    @rooms = Room.default_where(q_params).page(params[:page])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html.phone
        format.html { redirect_to admin_rooms_url }
        format.js { redirect_back fallback_location: admin_rooms_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_rooms_url }
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
        format.html { redirect_to admin_rooms_url }
        format.js { redirect_back fallback_location: admin_rooms_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: admin_rooms_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @room.destroy
    redirect_to admin_rooms_url
  end

  private
  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    p = params.fetch(:room, {}).permit(
      :room_number,
      :color,
      :limit_number
    )
    p.merge! default_params
  end

end
