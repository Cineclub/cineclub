class TeamPolicy < ApplicationPolicy
  def create_round?
    user.present? && member?
  end

  def create_invitation?
    member?
  end

  def join?
    record.empty?
  end

  private

  def member?
    user.member_of?(record)
  end
end
