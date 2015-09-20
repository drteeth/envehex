class Parser

  def go
    parse stuff
  end

  def stuff
    url = 'https://weather.gc.ca'
    client = Faraday.new url: url
    response = client.get '/rss/city/on-143_e.xml'
    response.body
  end

  def parse(xml)
    doc = Nokogiri::XML(xml)
    weather = Weather.new(nil, [], [])
    doc.xpath('//xmlns:entry').each do |entry|
      title = entry.xpath('xmlns:title').text
      link = entry.xpath('xmlns:link').attribute('href').value
      category = entry.xpath('xmlns:category').attribute('term').value
      summary = entry.xpath('xmlns:summary').text

      case category
      when 'Warnings and Watches'
        weather.warnings << Warning.new(title, link)
      when 'Current Conditions'
        weather.current = parse_current(title)
      when 'Weather Forecasts'
        weather.forecasts << Forecast.new(title, summary)
      end
    end
    weather
  end

  def parse_current(title)
    # Current Conditions: Clear, -3.0&#xB0;C
    chunks = title.split(/:|,/)
    temperature = chunks[2].strip
    conditions = chunks[1].strip
    Current.new(temperature, conditions)
  end

  Weather = Struct.new(:current, :warnings, :forecasts)

  Warning = Struct.new(:text, :link)

  Current = Struct.new(:temperature, :conditions)

end
