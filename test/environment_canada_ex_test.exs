defmodule EnvironmentCanadaTest do
  use ExUnit.Case

  test "the truth" do
    IO.inspect Thinger.foo_it(EnvironmentCanada.fetch('on-143_e'))
  end
end
