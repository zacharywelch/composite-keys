class Song < ApplicationRecord
  multi_tenant :company
  belongs_to :album
end
