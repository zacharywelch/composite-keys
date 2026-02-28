class Album < ApplicationRecord
  multi_tenant :company
  belongs_to :artist
  has_many :songs
end
