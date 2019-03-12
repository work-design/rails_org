class Org::Admin::ResignsController < Org::Admin::BaseController
  before_action :set_resign, only: [:show, :edit, :update, :destroy]

  def index
    q_params = params.fetch(:q, {}).permit!
    @resigns = Resign.default_where(q_params).order(id: :desc).page(params[:page])
  end

  def my
    if current_member.leading_office
      q_params = {
        'member.office_id': current_member.leading_office.id,
        state: Resign::states[:init]
      }.with_indifferent_access
      q_params.merge! params.permit!
      @resigns = Resign.default_where(q_params).order(id: :desc).page(params[:page])
    else
      @resigns = Resign.none.page(params[:page])
    end

    render :my, layout: 'my'
  end

  def new
    @resign = Resign.new
  end

  def create
    @resign = Resign.new(resign_params)

    if @resign.save
      redirect_to admin_resigns_url, notice: 'Resign was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @resign.update(resign_params)
      redirect_to admin_resigns_url, notice: 'Resign was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @resign.destroy
    redirect_to admin_resigns_url, notice: 'Resign was successfully destroyed.'
  end

  def charts
    q_params = params.fetch(:q, {}).permit(:id, 'leave_on-gte', 'leave_on-lte')
    resigns = Resign.select(:id, :member_id).default_where(q_params)
    resign_reasons = ResignReason.select([:id, :name]).where(parent_id: nil)
    offices = Office.select([:id, :name_short])

    labels = []
    datasets = []
    resign_reasons.each do |resign_reason|
      labels << resign_reason.name
    end
    offices.each_with_index do |office, index|
      next if office.name_short.nil?
      data = []
      resign_reasons.each do |resign_reason|
        q_count = 0
        resigns.each do |re|
          if (re.resign_reasons & resign_reason.children).length > 0 && re.member.office == office
            q_count = q_count + 1
          end
        end
        data << q_count
      end
      color = Office.colors[index]
      label = office.name_short
      datasets << {label: label, data: data, backgroundColor: color}
    end

    # labels2 = []
    # datasets2 = []
    #
    # id = q_params[:id] || 26
    #
    # resign_reason = ResignReason.find(id)
    # title = resign_reason.name
    # reason_children = resign_reason.children
    # reason_children.each do |reason_child|
    #   labels2 << reason_child.name
    # end
    #
    # offices.each_with_index do |office, index|
    #   next if office.name_short.nil?
    #   data = []
    #   reason_children.each do |reason_child|
    #     child_count = 0
    #     resigns.each do |re|
    #       if re.resign_reasons.include? reason_child
    #         child_count = child_count + 1
    #       end
    #     end
    #     data << child_count
    #   end
    #   color = Office.colors[index]
    #   label = office.name_short
    #   datasets2 << {label: label, data: data, backgroundColor: color}
    # end

    @data = { main_chart:{labels: labels, datasets: datasets}}.to_json
  end

  private
  def set_resign
    @resign = Resign.find(params[:id])
  end

  def resign_params
    params.fetch(:resign, {}).permit(
                                  :leave_on,
                                  :reason_note,
                                  :handover_note,
                                  :state,
                                  :comment,
                                  resign_reason_ids: []
                                )
  end

end
