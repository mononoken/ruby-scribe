class Invitation < ApplicationRecord
  belongs_to :collection
  belongs_to :journal
end