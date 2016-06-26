class ImpressionController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    # UserAgentを参照し、ブラウザ等判定をする
    impression = Impression.new(agent_params)
    impression.save
    render :nothing => true
  end

  private
    def agent_params
      params.require(:agent).permit(:appName, :appVersion, :device, :userAgent, :nowUrl)
    end
end
