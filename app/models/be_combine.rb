class BeCombine < ActiveRecord::Base
  belongs_to :body
  belongs_to :engine
  has_one :rating, :as => :rateable
  has_many :consumptions, :as => :consumable
end
