defmodule EnvironmentCanadaTest do
  use ExUnit.Case

  test "parsing" do
    IO.inspect Weather.parse(EnvironmentCanada.fetch('on-143_e'))
  end
end
