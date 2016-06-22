class ImpressionController < ApplicationController
  protect_from_forgery with: :null_session

  def index
  end

  def create
    # UserAgentを参照し、ブラウザ等判定をする
    Impression.analytics(params[:agent])
    render 'index'
  end
end
