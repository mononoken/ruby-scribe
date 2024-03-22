class CampaignPolicy < ApplicationPolicy
  default_rule :manage?

  def index?
    record.all? do |campaign|
      campaign.members.any? { |member| user.id == member.id }
    end
  end

  def new?
    user.present?
  end

  def create?
    owner?
  end

  def show?
    owner? || member?
  end

  def manage?
    owner?
  end

  private

  def owner?
    user.id == record.owner_id
  end

  def member?
    record.members.any? { |member| user == member }
  end
end
