class RoundPolicy < ApplicationPolicy
  def create?
    user.member_of?(record.team)
  end
end
