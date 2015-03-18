require 'test_helper'

class ForecastTest < ActiveSupport::TestCase

  setup do
    @samples = [
      "Sunday night: A few clouds. Low plus 1.",
      "Monday: A mix of sun and cloud. High 13.",
      "Monday night: Chance of showers. Low minus 1. POP 40%",
      "Tuesday: Sunny. High plus 1.",
      "Wednesday: Sunny. Low minus 8. High plus 2.",
      "Thursday: Sunny. Low minus 8. High plus 2.",
      "Friday: Chance of flurries. Low minus 6. High plus 2. POP 60%",
      "Saturday: Chance of flurries. Low minus 7. High plus 1. POP 40%",
    ]
    @forecasts = @samples.map do |line|
      Forecast.new(line, '')
    end
  end

  test "days" do
    expected = [
      'Sunday night',
      'Monday',
      'Monday night',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ]

    assert_equal expected, @forecasts.map(&:day)
  end

  test "lows" do
    expected = [
      'Low plus 1',
      nil,
      'Low minus 1',
      nil,
      'Low minus 8',
      'Low minus 8',
      'Low minus 6',
      'Low minus 7',
    ]

    assert_equal expected, @forecasts.map(&:low)
  end

  test "highs" do
    expected = [
      nil,
      'High 13',
      nil,
      'High plus 1',
      'High plus 2',
      'High plus 2',
      'High plus 2',
      'High plus 1',
    ]

    assert_equal expected, @forecasts.map(&:high)
  end

  test "pops" do
    expected = [
      nil,
      nil,
      'POP 40%',
      nil,
      nil,
      nil,
      'POP 60%',
      'POP 40%',
    ]

    assert_equal expected, @forecasts.map(&:pop)
  end

  test "quick summaries" do
    expected = [
      'A few clouds',
      'A mix of sun and cloud',
      'Chance of showers',
      'Sunny',
      'Sunny',
      'Sunny',
      'Chance of flurries',
      'Chance of flurries',
    ]

    assert_equal expected, @forecasts.map(&:quick_summary)
  end

end
