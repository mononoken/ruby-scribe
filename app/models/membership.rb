class Membership < ApplicationRecord
  belongs_to :collection
  belongs_to :member, class_name: "User"
  belongs_to :journal
end
