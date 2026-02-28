class Album < ApplicationRecord
  acts_as_tenant :company
  belongs_to :artist
  has_many :songs
  query_constraints :company_id, :id
end
