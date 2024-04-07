class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :journals, foreign_key: "author_id", inverse_of: "author",
    dependent: :destroy
  has_many :notes, foreign_key: "author_id", inverse_of: "author",
    dependent: :destroy
  has_many :comments, foreign_key: "author_id", inverse_of: "author",
    dependent: :destroy
  has_many :owned_campaigns, class_name: "Campaign",
    foreign_key: "owner_id", inverse_of: "owner", dependent: :destroy
  has_many :memberships, foreign_key: "member_id", inverse_of: "member",
    dependent: :destroy
  has_many :membership_journals, through: :memberships,
    foreign_key: "member_id", inverse_of: "member", dependent: :destroy
  has_many :campaigns, through: :memberships,
    dependent: :destroy
  has_many :sent_invitations, class_name: "Invitation",
    foreign_key: "sender_id", dependent: :destroy
  has_many :received_invitations, class_name: "Invitation",
    foreign_key: "recipient_id", dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
end
