class Impression < ActiveRecord::Base
  attr_accessor :appName, :appVersion, :device, :userAgent, :nowUrl
  before_create :analytics

  def analytics
    self.url = nowUrl
    self.browser = browser_check
    self.browser_version = browser_version_check
    self.platform = device
  end

  def self.day_select
    from = Time.now.at_beginning_of_day
    to = from.at_end_of_day
    where(created_at: from...to)
  end

  def self.week_select
    to = Time.now.at_beginning_of_day
    from = (to - 7.day).at_end_of_day
    where(created_at: from...to)
  end

  def self.month_select
    from = Time.now.beginning_of_month
    to = Time.now.end_of_month
    where(created_at: from...to)
  end

  def self.url_count
    group(:url).count
  end

  def self.browser_count
    group(:browser).count
  end

  def self.browser_version_count
    group(:browser_version).count
  end

  def self.platform_count
    group(:platform).count
  end

private

  # Browser種類を判定する
  def browser_check
    # 　IE判定
    if appName.include? 'Internet Explorer'
      'Internet Explorer'
      # Opera判定
    elsif appName.include? 'Opera'
      'Opera'
      # Safari Chrome判定
    elsif appVersion.include? 'Safari'
      # Chrome判定
      if appVersion.include? 'Chrome'
        'Google Chrome'
      else
        # Safari判定
        'Safari'
      end
      # FireFox判定
    elsif userAgent.include? 'FireFox'
      'FireFox'
      # その他
    else
      'unknown'
    end
  end

  # browser_versionを判定する
  def browser_version_check
    case browser
    when 'Internet Explorer' then
      st = userAgent.index('MSIE')
      en = userAgent.index(';')
      plus = 4
    when 'Opera' then
      st = userAgent.index('Version')
      en = userAgent.length
      plus = 8
    when 'Safari' then
      st = userAgent.index('Version')
      en = userAgent.index(' ', st)
      plus = 8
    when 'Google Chrome' then
      st = userAgent.index('Chrome')
      en = userAgent.index(' ', st)
      plus = 7
    when 'FireFox' then
      st = userAgent.index('FireFox')
      en = userAgent.length
      plus = 8
    else
      return ''
    end
    userAgent.slice(st + plus..en)
  end
end
