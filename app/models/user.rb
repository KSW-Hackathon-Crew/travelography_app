class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  has_secure_password

  # methods for use with geocoder, can't tell if they work until we are uploade to Heroku
  def get_location
    @street = request.location.street
    @city = request.location.city
    @state = request.location.state
    @country = request.location.country
  end

  def longitude
    request.location.longitude
  end

  def latitude
    request.location.latitude
  end

  def address
    [@street, @city, @state, @country].compact.join(', ')
  end


end
