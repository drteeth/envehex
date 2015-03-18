class ApiController < ApplicationController

  def weather

  end

  private

  def city
    params[:city]
  end

end
