url = ['http://192.168.33.11:3000/422.html', 'http://192.168.33.11:3000/500.html', 'http://192.168.33.11:3000/', 'http://192.168.33.11:3000/404.html']
browser = ['Internet Explorer', 'Safari', 'Opera', 'Google Chrome']
browser_version = ['10.0', '9.1.1', '11.50', '51.0.2704.84']
platform = %w(Windows MacIntel Linux iPhone)

1000.times do
  i = rand(0..3)
  u = url[i]
  br = browser[i]
  brv = browser_version[i]
  pl = platform[i]
  created_at = "2016-0#{rand(1..5)}-#{rand(1..30)} #{rand(0..24)}:#{rand(0..59)}:#{rand(0..59)}"
  # created_at = "2016-06-#{rand(1..30)} #{rand(0..24)}:#{rand(0..59)}:#{rand(0..59)}"
  # created_at = "2016-06-25 #{rand(0..24)}:#{rand(0..59)}:#{rand(0..59)}"
  Impression.create(url: u, browser: br, browser_version: brv, platform: pl, created_at: created_at)
end

500.times do
  i = rand(0..2)
  u = url[i]
  br = browser[i]
  brv = browser_version[i]
  pl = platform[i]
  # created_at = "2016-0#{rand(1..5)}-#{rand(1..30)} #{rand(0..24)}:#{rand(0..59)}:#{rand(0..59)}"
  created_at = "2016-06-#{rand(1..30)} #{rand(0..24)}:#{rand(0..59)}:#{rand(0..59)}"
  # created_at = "2016-06-25 #{rand(0..24)}:#{rand(0..59)}:#{rand(0..59)}"
  Impression.create(url: u, browser: br, browser_version: brv, platform: pl, created_at: created_at)
end

50.times do
  u = url[rand(0..3)]
  br = 'unknown'
  brv = 'unknown'
  pl = 'Linux'
  created_at = "2016-06-#{rand(1..30)} #{rand(0..24)}:#{rand(0..59)}:#{rand(0..59)}"
  Impression.create(url: u, browser: br, browser_version: brv, platform: pl, created_at: created_at)
end
