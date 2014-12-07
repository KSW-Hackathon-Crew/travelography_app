class SessionsController < ApplicationController

  def show
    location = URI.encode(params[:location])
    foursquare = HTTParty.get("https://api.foursquare.com/v2/venues/explore?near=#{location}&venuePhotos=1&oauth_token=CHO2KGDBYG5Y3ZWHEXQFL1WEMPZIQXL4RFTKWCK5Y54TEXEX&v=20120609")

    @activities = []

    foursquare["response"]["groups"][0]["items"].each do |fs|
      img_pre = fs["venue"]["photos"]["groups"][0]["items"][0]["prefix"]
      img_suff = fs["venue"]["photos"]["groups"][0]["items"][0]["suffix"]
      @activities << {
        name: fs["venue"]["name"],
        category: fs["venue"]["categories"][0]["pluralName"], 
        photo_url: img_pre + '300x300' + img_suff,
        location: fs["venue"]["location"]["formattedAddress"][0] + "\n" + fs["venue"]["location"]["formattedAddress"][1],
        lat: fs["venue"]["location"]["lat"],
        long: fs["venue"]["location"]["lng"], 
        url: fs["venue"]["url"]
      }

      fs["tips"].each do |tip|
        if tip["photourl"]
          img_p = tip["photo"]["prefix"]
          img_s = tip["photo"]["suffix"]
          @activities << {
            name: fs["venue"]["name"],
            text: tip["text"],
            category: "Tips",
            photo_url: img_p + "300x300" + img_s,
            location: fs["venue"]["location"]["formattedAddress"][0] + "\n" + fs["venue"]["location"]["formattedAddress"][1],
            lat: fs["venue"]["location"]["lat"],
            long: fs["venue"]["location"]["lng"],
            url: tip["url"]  
          }
        end
      end
    end

    respond_to do |format|
      format.json { render :json => @activities }
    end
  end


end
