class Song < ApplicationRecord
  acts_as_tenant :company, composite_keys: true
  belongs_to :album
end
