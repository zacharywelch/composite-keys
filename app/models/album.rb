class Album < ApplicationRecord
  acts_as_tenant :company, composite_keys: true
  belongs_to :artist
  has_many :songs
end
