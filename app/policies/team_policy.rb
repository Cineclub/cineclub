class TeamPolicy < ApplicationPolicy
  def create_round?
    user.present? && user.member_of?(record)
  end
end
