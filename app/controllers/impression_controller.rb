class ImpressionController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    # UserAgentを参照し、ブラウザ等判定をする
    impression = Impression.new
    impression.analytics(params[:agent])
    render :nothing => true
  end
end
