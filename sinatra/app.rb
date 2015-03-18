require 'sinatra'
require 'faraday'
require 'nokogiri'

get '/' do
  conn = Faraday.new(url: 'https://weather.gc.ca')

  response = conn.get '/rss/city/on-143_e.xml'
  doc = Nokogiri::XML(response.body)

  doc.xpath('//xmlns:entry') do |feed_node|
    # <title>No watches or warnings in effect, Toronto</title>
    # <link type="text/html" href="http://www.weather.gc.ca/warnings/index_e.html"/>
    # <updated>2015-03-14T17:15:00Z</updated>
    # <published>2015-03-14T17:15:00Z</published>
    # <category term="Warnings and Watches"/>
    # <summary type="html">No watches or warnings in effect.</summary>

    # <title>Current Conditions: Cloudy, 2.4°C</title>
    # <link type="text/html" href="http://www.weather.gc.ca/city/pages/on-143_metric_e.html"/>
    # <updated>2015-03-15T03:17:00Z</updated>
    # <published>2015-03-15T03:17:00Z</published>
    # <category term="Current Conditions"/>
    # <summary type="html">
    # <![CDATA[
    # <b>Observed at:</b> Toronto Pearson Int'l Airport 11:17 PM EDT Saturday 14 March 2015 <br/> <b>Condition:</b> Cloudy <br/> <b>Temperature:</b> 2.4&deg;C <br/> <b>Pressure / Tendency:</b> 101.0 kPa rising<br/> <b>Visibility:</b> 24.1 km<br/> <b>Humidity:</b> 74 %<br/> <b>Dewpoint:</b> -1.8&deg;C <br/> <b>Wind:</b> WNW 23 km/h gust 36 km/h<br/> <b>Air Quality Health Index:</b> 2 <br/>
    # ]]>
    # </summary>

    title = feed_node[:title]
    link = feed_node[:link]
    category = feed_node[:category][:term]
    puts title, link, category
  end
  'hi'
end
