class Impression < ActiveRecord::Base
  def analytics(agent)
    # UserAgent を解体しDBにコミットする
    self.url = agent['url']
    self.browser = browser?(agent)
    self.browser_version = browser_version?(agent['userAgent'])
    self.platform = agent['platform']
    save
  end

  # Browser種類を判定する
  def browser?(agent)
    # 　IE判定
    if agent['appName'].include? 'Internet Explorer'
      'Internet Explorer'
      # Opera判定
    elsif agent['appName'].include? 'Opera'
      'Opera'
      # Safari Chrome判定
    elsif agent['appVersion'].include? 'Safari'
      # Chrome判定
      if agent['appVersion'].include? 'Chrome'
        'Google Chrome'
      else
        # Safari判定
        'Safari'
      end
      # FireFox判定
    elsif agent['userAgent'].include? 'FireFox'
      'FireFox'
      # その他
    else
      'unknown'
    end
  end

  # browser_versionを判定する
  def browser_version?(userAgent)
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
