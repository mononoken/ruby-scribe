class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :journals, foreign_key: "author_id", inverse_of: "author"
  has_many :notes, foreign_key: "author_id", inverse_of: "author"
end
