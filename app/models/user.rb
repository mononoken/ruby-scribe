class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :journals, foreign_key: "author_id", inverse_of: "author",
    dependent: :destroy
  has_many :notes, foreign_key: "author_id", inverse_of: "author",
    dependent: :destroy
  has_many :owned_collections, class_name: "Collection",
    foreign_key: "owner_id", inverse_of: "owner", dependent: :destroy
  has_many :memberships, foreign_key: "member_id", inverse_of: "member",
    dependent: :destroy
  has_many :collections, through: :memberships,
    dependent: :destroy
end
