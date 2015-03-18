class ApiController < ApplicationController

  def weather
    Foo.new
  end

  private

  def city
    params[:city]
  end

end
