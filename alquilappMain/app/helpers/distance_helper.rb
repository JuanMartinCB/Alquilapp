module DistanceHelper  

    # def distance (vid)
    #     distance_between(session[:lat], session[:lng], Vehicle.find(vid).location.x, Vehicle.find(vid).location.y)
    # end
    # #define a method to calculate distance between two points
    # protected
    # def distance_between(lat1, lon1, lat2, lon2)
    #     #convert degrees to radians
    #     lat1 = lat1 * Math::PI / 180
    #     lon1 = lon1 * Math::PI / 180
    #     lat2 = lat2 * Math::PI / 180
    #     lon2 = lon2 * Math::PI / 180
    #     #calculate distance
    #     dlon = lon2 - lon1
    #     dlat = lat2 - lat1
    #     a = (Math.sin(dlat/2))**2 + Math.cos(lat1) * Math.cos(lat2) * (Math.sin(dlon/2))**2
    #     c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))
    #     d = 6371 * c
    #     return d
    # end
    def distance (vid)
        if session[:lat].nil? || session[:lng].nil?
            return " "
        else
            d=distance_between2([session[:lat],session[:lng]], Vehicle.find(vid).location)
            if d< 1000
                return d.round.to_s + " m"
            else
                return (d/1000).round(2).to_s + " Km"
            end
        end
    end

    private
    def distance_between2(loc1, loc2)
        rad_per_deg = Math::PI/180  # PI / 180
        rkm         = 6371          # Earth radius in kilometers
        rm          = rkm * 1000    # Radius in meters
      
        dlat_rad    = (loc2[0]-loc1[0]) * rad_per_deg # Delta, converted to rad
        dlon_rad    = (loc2[1]-loc1[1]) * rad_per_deg
      
        lat1_rad    = loc1.map {|i| i * rad_per_deg }.first
        lat2_rad    = loc2.map {|i| i * rad_per_deg }.first
      
        a           = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
        c           = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
      
        rm * c # Delta in meters
      end
      
      def calc
        loc1 = [3.1502978,101.6511437]
        loc2 = [3.1560868,101.6574744]
        puts "#{distance(loc1, loc2).round(2)} meters"
      end

end