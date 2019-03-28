class Org::MembersController < ApplicationController
  before_action :set_member, only: [:show]

  def index
    q_params = params.fetch(:q, {}).permit!
    q_params.merge! params.permit(:office_id)
    @members = Member.includes(:department, user: { avatar_attachment: :blob }).where(enabled: true).default_where(q_params).page(params[:page]).per(30)
  end

  def search
    if params[:q].present?
      @members = Member.where(enabled: true).default_where('name-like': params[:q])
    else
      @members = Member.none
    end

    render json: { results: @members.as_json(only: [:name, :id]) }
  end

  def show
  end

  def people
    @members = Member.where(enabled: true)
    @test = 111
  end

  def journals
    @journals = Journal.all
  end

  def sections
    @sections = Department.find_all_by_generation(1)
  end

  def groups
    @groups = Department.find_all_by_generation(2)
  end

  private
  def set_member
    @member = Member.find(params[:id])
  end

end
