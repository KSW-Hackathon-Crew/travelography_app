class Activity < ActiveRecord::Base
  belongs_to :plan
  has_many :photos
end
