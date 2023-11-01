class Comment < ApplicationRecord
  belongs_to :note
  belongs_to :author, class_name: "User"
end
