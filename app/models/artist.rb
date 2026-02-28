class Artist < ApplicationRecord
  multi_tenant :company
  has_many :albums
  has_many :songs, through: :albums
end
