module AnalyticsHelper
  def today?
    from  = Time.now.at_beginning_of_day
    to    = from.at_end_of_day
    items = Impression.where(created_at: from...to).count
  end

  def week?
    from  = Time.now.at_beginning_of_day
    to    = (from + 6.day).at_end_of_day
    items = Impression.where(created_at: from...to)
  end
end
