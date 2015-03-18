class Forecast
  attr_reader :high, :low, :pop, :quick_summary, :day

  def initialize(title, summary)
    @stuff = split(title)
    @title = title
    @summary = summary
  end

  def time_period
    @stuff[0]
  end

  def split(title)
    chunks = title.split(/:|\./)
    chunks.each do |chunk|
      c = chunk.strip
      @high = c if c =~ /\AHigh+/
      @low = c if c =~ /\ALow+/
      @pop = c if c =~ /\APOP+/
    end
    @day = chunks.first.strip
    @quick_summary = chunks.second.strip
  end

end
