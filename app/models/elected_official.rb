class ElectedOfficial < ApplicationRecord
    belongs_to :police_district
    validates_presence_of :name, :position
  end
  