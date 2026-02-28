class Artist < ApplicationRecord
  acts_as_tenant :company, composite_keys: true
  has_many :albums
  has_many :songs, through: :albums
end
