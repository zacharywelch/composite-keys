class Song < ApplicationRecord
  acts_as_tenant :company
  belongs_to :album
  query_constraints :company_id, :id
end
