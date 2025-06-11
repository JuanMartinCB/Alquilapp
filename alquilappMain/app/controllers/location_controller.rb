class LocationController < ApplicationController
  
  def create 
    session[:lat] = params[:lat].to_f
    session[:lng] = params[:lng].to_f
  end

  #creta a method to get the location of the user
  def get_location
    @lat = session[:lat]
    @lng = session[:lng]
  end
end
