class AnalyticsController < ApplicationController
  def index
    # All days
    # 総PV数
    @allcount_data = Impression.count
    # URL別
    @each_url_data = Impression.group(:url).count
    # browser別
    @each_browser_data = Impression.group(:browser).count
    # 端末別
    @each_platform_data = Impression.group(:platform).count

    # past 24hours
    # browser別
    @time_each_browser_data = Impression.group(:browser).group_by_hour_of_day(:created_at, format: '%l %P').count

    # URL別
    @alltime_each_url_data = Impression.group(:url).group_by_hour_of_day(:created_at, format: '%l %P').count
  end
end
