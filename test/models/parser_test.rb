require 'test_helper'

class ParserTest < ActiveSupport::TestCase

  setup do
    @parse = Parser.new.parse(XML)
  end

  test "there is 1 warnings" do
    assert_equal 1, @parse.warnings.length
  end

  test "warning text" do
    assert_equal 'No watches or warnings in effect, Toronto', warning.text
  end

  test "warning link" do
    assert_equal 'http://www.weather.gc.ca/warnings/index_e.html', warning.link
  end

  test "current temperature" do
    assert_equal '-3.0°C', current.temperature
  end

  test "current conditions" do
    assert_equal 'Clear', current.conditions
  end

  private

  def warning
    @parse.warnings.first
  end

  def current
    @parse.current
  end

  XML = <<-XML
    <?xml version="1.0" encoding="UTF-8"?>
     <feed xmlns="http://www.w3.org/2005/Atom" xml:lang="en-ca">

    <!--
    This is a data file that is meant to be read by RSS readers or aggregators.
    See http://www.ec.gc.ca/meteo-weather/default.asp?lang=En&n=11703207-1 to learn more about our RSS service.
    -->

     <title>Toronto - Weather - Environment Canada</title>
     <link rel="related" href="http://www.weather.gc.ca/city/pages/on-143_metric_e.html" type="text/html"/>
     <link rel="self" href="http://www.weather.gc.ca/rss/city/on-143_e.xml" type="application/atom+xml"/>
     <link rel="alternate" hreflang="fr-ca" href="http://www.meteo.gc.ca/rss/city/on-143_f.xml" type="application/atom+xml"/>
     <author>
     <name>Environment Canada</name>
     <uri>http://www.weather.gc.ca</uri>
     </author>
     <updated>2015-03-18T03:01:20Z</updated>
     <id>tag:weather.gc.ca,2013-04-16:20150318030120</id>
     <logo>http://www.weather.gc.ca/build/theme-gcwu-fegc/images/wmms.gif</logo>
     <icon>http://www.weather.gc.ca/build/theme-gcwu-fegc/images/favicon.ico</icon>
     <rights>Copyright 2015, Environment Canada</rights>
     <entry>
     <title>No watches or warnings in effect, Toronto</title>
     <link type="text/html" href="http://www.weather.gc.ca/warnings/index_e.html"/>
     <updated>2015-03-14T17:15:00Z</updated>
     <published>2015-03-14T17:15:00Z</published>
     <category term="Warnings and Watches"/>
     <summary type="html">No watches or warnings in effect.</summary>
     <id>tag:weather.gc.ca,2013-04-16:on-143_w1:20150314171500</id>
     </entry>
     <entry>
     <title>Current Conditions: Clear, -3.0&#xB0;C</title>
     <link type="text/html" href="http://www.weather.gc.ca/city/pages/on-143_metric_e.html"/>
     <updated>2015-03-18T03:00:00Z</updated>
     <published>2015-03-18T03:00:00Z</published>
     <category term="Current Conditions"/>
     <summary type="html"><![CDATA[<b>Observed at:</b> Toronto Pearson Int'l Airport 11:00 PM EDT Tuesday 17 March 2015 <br/>
    <b>Condition:</b> Clear <br/>
    <b>Temperature:</b> -3.0&deg;C <br/>
    <b>Pressure / Tendency:</b> 102.0 kPa rising<br/>
    <b>Visibility:</b> 24.1 km<br/>
    <b>Humidity:</b> 50 %<br/>
    <b>Wind Chill:</b> -12 <br/>
    <b>Dewpoint:</b> -12.0&deg;C <br/>
    <b>Wind:</b> NW 42 km/h gust 60 km/h<br/>
    <b>Air Quality Health Index:</b> 3 <br/>
    ]]></summary>
     <id>tag:weather.gc.ca,2013-04-16:on-143_cc:20150318030000</id>
     </entry>
     <entry>
     <title>Tuesday night: Clear. Low minus 8.</title>
     <link type="text/html" href="http://www.weather.gc.ca/city/pages/on-143_metric_e.html"/>
     <updated>2015-03-17T19:30:00Z</updated>
     <published>2015-03-17T19:30:00Z</published>
     <category term="Weather Forecasts"/>
     <summary type="html">Clear. Wind north 40 km/h gusting to 60 becoming northwest 20 this evening. Low minus 8. Forecast issued 3:30 PM EDT Tuesday 17 March 2015</summary>
     <id>tag:weather.gc.ca,2013-04-16:on-143_fc1:20150317193000</id>
     </entry>
     <entry>
     <title>Wednesday: Sunny. High plus 3.</title>
     <link type="text/html" href="http://www.weather.gc.ca/city/pages/on-143_metric_e.html"/>
     <updated>2015-03-17T19:30:00Z</updated>
     <published>2015-03-17T19:30:00Z</published>
     <category term="Weather Forecasts"/>
     <summary type="html">Sunny. Wind northwest 20 km/h. High plus 3. UV index 4 or moderate. Forecast issued 3:30 PM EDT Tuesday 17 March 2015</summary>
     <id>tag:weather.gc.ca,2013-04-16:on-143_fc2:20150317193000</id>
     </entry>
     <entry>
     <title>Wednesday night: A few clouds. Low minus 7.</title>
     <link type="text/html" href="http://www.weather.gc.ca/city/pages/on-143_metric_e.html"/>
     <updated>2015-03-17T19:30:00Z</updated>
     <published>2015-03-17T19:30:00Z</published>
     <category term="Weather Forecasts"/>
     <summary type="html">A few clouds. Low minus 7. Forecast issued 3:30 PM EDT Tuesday 17 March 2015</summary>
     <id>tag:weather.gc.ca,2013-04-16:on-143_fc3:20150317193000</id>
     </entry>
     <entry>
     <title>Thursday: Sunny. High plus 4.</title>
     <link type="text/html" href="http://www.weather.gc.ca/city/pages/on-143_metric_e.html"/>
     <updated>2015-03-17T19:30:00Z</updated>
     <published>2015-03-17T19:30:00Z</published>
     <category term="Weather Forecasts"/>
     <summary type="html">Sunny. High plus 4. Forecast issued 3:30 PM EDT Tuesday 17 March 2015</summary>
     <id>tag:weather.gc.ca,2013-04-16:on-143_fc4:20150317193000</id>
     </entry>
     <entry>
     <title>Friday: Chance of showers. Low minus 3. High 6. POP 30%</title>
     <link type="text/html" href="http://www.weather.gc.ca/city/pages/on-143_metric_e.html"/>
     <updated>2015-03-17T19:30:00Z</updated>
     <published>2015-03-17T19:30:00Z</published>
     <category term="Weather Forecasts"/>
     <summary type="html">Cloudy with 30 percent chance of showers. Low minus 3. High 6. Forecast issued 3:30 PM EDT Tuesday 17 March 2015</summary>
     <id>tag:weather.gc.ca,2013-04-16:on-143_fc5:20150317193000</id>
     </entry>
     <entry>
     <title>Saturday: Chance of flurries. Low minus 3. High plus 3. POP 40%</title>
     <link type="text/html" href="http://www.weather.gc.ca/city/pages/on-143_metric_e.html"/>
     <updated>2015-03-17T19:30:00Z</updated>
     <published>2015-03-17T19:30:00Z</published>
     <category term="Weather Forecasts"/>
     <summary type="html">A mix of sun and cloud with 40 percent chance of flurries. Low minus 3. High plus 3. Forecast issued 3:30 PM EDT Tuesday 17 March 2015</summary>
     <id>tag:weather.gc.ca,2013-04-16:on-143_fc6:20150317193000</id>
     </entry>
     <entry>
     <title>Sunday: A mix of sun and cloud. Low minus 12. High zero.</title>
     <link type="text/html" href="http://www.weather.gc.ca/city/pages/on-143_metric_e.html"/>
     <updated>2015-03-17T19:30:00Z</updated>
     <published>2015-03-17T19:30:00Z</published>
     <category term="Weather Forecasts"/>
     <summary type="html">A mix of sun and cloud. Low minus 12. High zero. Forecast issued 3:30 PM EDT Tuesday 17 March 2015</summary>
     <id>tag:weather.gc.ca,2013-04-16:on-143_fc7:20150317193000</id>
     </entry>
     <entry>
     <title>Monday: Sunny. Low minus 9. High plus 2.</title>
     <link type="text/html" href="http://www.weather.gc.ca/city/pages/on-143_metric_e.html"/>
     <updated>2015-03-17T19:30:00Z</updated>
     <published>2015-03-17T19:30:00Z</published>
     <category term="Weather Forecasts"/>
     <summary type="html">Sunny. Low minus 9. High plus 2. Forecast issued 3:30 PM EDT Tuesday 17 March 2015</summary>
     <id>tag:weather.gc.ca,2013-04-16:on-143_fc8:20150317193000</id>
     </entry>
     </feed>
  XML

end
