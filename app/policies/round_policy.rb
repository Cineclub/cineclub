class RoundPolicy < ApplicationPolicy
  def create_screening?
    user.member_of?(record.team)
  end

  def update?
    record.user == user
  end
end
