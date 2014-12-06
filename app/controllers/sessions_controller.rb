class SessionsController < ApplicationController

  def index
    venues = HTTParty.get('https://api.foursquare.com/v2/venues/explore?near=40.7,-74&venuePhotos=1&oauth_token=CHO2KGDBYG5Y3ZWHEXQFL1WEMPZIQXL4RFTKWCK5Y54TEXEX&v=20120609')

    @venue_images = []

    venues["response"]["groups"][0]["items"].each do |venue|
      img_pre = venue["venue"]["photos"]["groups"][0]["items"][0]["prefix"]
      img_suff = venue["venue"]["photos"]["groups"][0]["items"][0]["suffix"]
      # img_width = venue["venue"]["photos"]["groups"][0]["items"][0]["width"]
      # img_height = venue["venue"]["photos"]["groups"][0]["items"][0]["height"]
      @venue_images << img_pre + '300x300' + img_suff
    end
  end


end
