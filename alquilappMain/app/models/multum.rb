class Multum < ApplicationRecord
    belongs_to :user
    has_one :wtransaction
end
