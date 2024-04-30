class CommentPolicy < ApplicationPolicy
  authorize :note, optional: true

  def index?
    allowed_to?(:manage?, note) || campaign_member?
  end

  def create?
    allowed_to?(:manage?, note) || campaign_member?
  end

  def show?
    author? || campaign_member?
  end

  def manage?
    author?
  end

  private

  def campaign_member?
    note.journal.campaigns.reduce([]) do |members, campaign|
      members + campaign.members
    end.uniq.any? { |member| user.id == member.id }
  end

  def note
    @note || record.note
  end
end
