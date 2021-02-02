class ScreeningPolicy < ApplicationPolicy
  def create?
    user.member_of?(record.round.team)
  end
end
