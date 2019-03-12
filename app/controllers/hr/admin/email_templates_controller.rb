class Hr::Admin::EmailTemplatesController < Hr::Admin::BaseController
  before_action :set_email_template, only: [:edit, :update, :destroy]

  def index
    q_params = params.fetch(:q, {}).permit!
    @email_templates = EmailTemplate.default_where(q_params).order(id: :desc).page(params[:page])
  end

  def new
    @email_template = EmailTemplate.new
  end

  def create
    @email_template = EmailTemplate.new(email_template_params)

    if @email_template.save
      redirect_to admin_email_templates_url, notice: 'Email template was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @email_template.update email_template_params
      redirect_to admin_email_templates_url, notice: 'Email template was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @email_template.destroy
    redirect_to admin_email_templates_url, notice: 'Email template was successfully destroyed.'
  end

  private
  def set_email_template
    @email_template = EmailTemplate.find(params[:id])
  end

  def email_template_params
    params.fetch(:email_template, {}).permit(
                                    :name,
                                    :subject,
                                    :body,
                                    :category,
                                    :file
    )
  end

end
