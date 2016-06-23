class ImpressionController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    # 総PV数
    @allcount_data = Impression.count
    # URL別のView数
    @each_url_data = Impression.group(:url).count
    # browser別View数
    @each_browser_data = Impression.group(:browser).count

    # 時間帯別
    # 総PVに対する時間帯別
    @time_allcount_data = Impression.group_by_hour_of_day(:created_at, format: '%l %P').count
    # URL別のView数に対する時間帯別
    @time_each_url_data = Impression.group(:url).group_by_hour_of_day(:created_at, format: '%l %P').count
    # browser別View数
    @time_each_browser_data = Impression.group(:browser).group_by_hour_of_day(:created_at, format: '%l %P').count
  end

  def create
    # UserAgentを参照し、ブラウザ等判定をする
    Impression.analytics(params[:agent])
    render 'index'
  end
end
