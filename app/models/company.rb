class Company < ApplicationRecord
  has_many :artists
  has_many :albums
  has_many :songs
end
