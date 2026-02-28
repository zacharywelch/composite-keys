class Song < ApplicationRecord
  acts_as_tenant :company
  belongs_to :album
end
