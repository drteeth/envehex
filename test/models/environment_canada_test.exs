defmodule EnvironmentCanadaTest do
  use ExUnit.Case

  test "parsing" do
    IO.inspect Stuff.parse(EnvironmentCanada.fetch('on-143_e'))
  end
end
