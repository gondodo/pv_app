class AnalyticsController < ApplicationController
  def index
    day = Impression.day_select
    week = Impression.week_select
    month = Impression.month_select

    # All
    # PV数
    @allcount = Impression.count
    # URL別
    @each_url_data = Impression.url_count
    # browser別
    @each_browser_data = Impression.browser_count
    # 端末別
    @each_platform_data = Impression.platform_count

    # Day
    # PV数
    @daycount = day.count
    # URL別
    @day_each_url_data = day.group(:url).group_by_hour_of_day(:created_at, format: '%l %P').count
    # browser別
    @day_each_browser_data = day.browser_count
    # 端末別
    @day_platform_data = day.platform_count

    # Week
    # PV数
    @weekcount = week.count
    # URL別
    @week_each_url_data = week.group(:url).group_by_day(:created_at, format: '%m/%d').count
    # browser別
    @week_each_browser_data = week.browser_count
    # 端末別
    @week_platform_data = week.platform_count

    # Month
    # PV数
    @monthcount = month.count
    # URL別
    @month_each_url_data = month.group(:url).group_by_day(:created_at, format: '%m/%d').count
    # browser別
    @month_each_browser_data = month.browser_count
    # 端末別
    @month_platform_data = month.platform_count
  end
end
