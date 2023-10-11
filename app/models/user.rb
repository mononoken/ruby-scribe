class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :journals, foreign_key: "author_id", inverse_of: "author",
    dependent: :destroy
  has_many :notes, foreign_key: "author_id", inverse_of: "author",
    dependent: :destroy
  has_many :collections, foreign_key: "owner_id", inverse_of: "owner",
    dependent: :destroy
end
