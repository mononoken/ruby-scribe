class NotePolicy < ApplicationPolicy
  authorize :journal, optional: true

  def index?
    allowed_to?(:manage?, journal) || campaign_member?
  end

  def create?
    allowed_to?(:manage?, journal)
  end

  def show?
    author? || campaign_member?
  end

  def manage?
    author?
  end

  private

  def campaign_member?
    journal.campaigns.reduce([]) do |members, campaign|
      members + campaign.members
    end.uniq.any? { |member| user.id == member.id }
  end

  def journal
    @journal || record.journal
  end
end
