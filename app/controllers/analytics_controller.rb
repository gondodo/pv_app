class AnalyticsController < ApplicationController
  def index
    day = day?
    week = week?
    month = month?

    # All
    # PV数
    @allcount = Impression.count
    # URL別
    @each_url_data = Impression.group(:url).count
    # browser別
    @each_browser_data = Impression.group(:browser).count
    # 端末別
    @each_platform_data = Impression.group(:platform).count

    # Day
    # PV数
    @daycount = day.count
    # URL別
    @day_each_url_data = day.group(:url).group_by_hour_of_day(:created_at, format: '%l %P').count
    # browser別
    @day_each_browser_data = day.group(:browser).count
    # 端末別
    @day_platform_data = day.group(:platform).count

    # Week
    # PV数
    @weekcount = week.count
    # URL別
    @week_each_url_data = week.group(:url).group_by_day(:created_at, format: '%m %d').count
    # browser別
    @week_each_browser_data = week.group(:browser).count
    # 端末別
    @week_platform_data = week.group(:platform).count

    # Month
    # PV数
    @monthcount = month.count
    # URL別
    @month_each_url_data = month.group(:url).group_by_day(:created_at, format: '%m %d').count
    # browser別
    @month_each_browser_data = month.group(:browser).count
    # 端末別
    @month_platform_data = month.group(:platform).count

  end

private
  def day?
    from  = Time.now.at_beginning_of_day
    to = from.at_end_of_day
    Impression.where(created_at: from...to)
  end

  def week?
    to  = Time.now.at_beginning_of_day
    from = (to - 7.day).at_end_of_day
    Impression.where(created_at: from...to)
  end

  def month?
    from = Time.now.beginning_of_month
    to = Time.now.end_of_month
    Impression.where(created_at: from...to)
  end
end
