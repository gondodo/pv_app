class Impression < ActiveRecord::Base
  attr_accessor :agent

  def self.analytics(agent)
    # UserAgent を解体しDBにコミットする
    impression = Impression.new
    impression.url = agent['url']
    impression.browser?(agent)
    impression.browser_version?(agent['userAgent'], impression.browser)
    impression.platform = agent['platform']
    impression.save
  end

  # Browser種類を判定する
  def browser?(agent)
    browser = self.browser
    # 　IE判定
    if agent['appName'].include? 'Internet Explorer'
      self.browser = 'Internet Explorer'
      # Opera判定
    elsif agent['appName'].include? 'Opera'
      self.browser = 'Opera'
      # Safari Chrome判定
    elsif agent['appVersion'].include? 'Safari'
      # Chrome判定
      self.browser = if agent['appVersion'].include? 'Chrome'
                       'Google Chrome'
                     else
                       # Safari判定
                       'Safari'
                     end
      # FireFox判定
    elsif agent['userAgent'].include? 'FireFox'
      self.browser = 'FireFox'
      # その他
    else
      self.browser = 'unknown'
    end
  end

  # browser_versionを判定する
  def browser_version?(userAgent, browser)
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
    self.browser_version = userAgent.slice(st + plus..en)
  end
end
