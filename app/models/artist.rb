class Artist < ApplicationRecord
  acts_as_tenant :company
  has_many :albums
  has_many :songs, through: :albums
  query_constraints :company_id, :id
end
