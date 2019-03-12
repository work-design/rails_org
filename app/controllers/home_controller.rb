class HomeController < ApplicationController
  before_action :check_variant

  def index

    respond_to do |format|
      if current_user
        format.html
      else
        format.html
      end
    end
  end

  def migrate

    render 'migrate', layout: nil
  end

  def uptoken
    uptoken = QiniuHelper.generate_uptoken(nil)
    render json: { uptoken: uptoken, key: nil }
  end

end
