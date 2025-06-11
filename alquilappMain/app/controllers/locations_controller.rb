class LocationsController < ApplicationController

    def create
        session[:lat] = params[:lat].to_f
        session[:lng] = params[:lng].to_f
        # if previous_lat.nil? && session[:lat].present?
        #     redirect_back fallback_location: root_path
        # end
    end
    
    #converts the session lat and lng to a point
    def point
        point = [session[:lat], session[:lng]]
        point
    end
    
end
