class Purchase < ApplicationRecord
  belongs_to :invoice
  enum result: [ :failed, :refunded, :success ]
end
