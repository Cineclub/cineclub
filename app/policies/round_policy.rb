class RoundPolicy < ApplicationPolicy
  def create_screening?
    user.member_of?(record.team)
  end

  def update_movie?
    user == record.user && !record.screenings.exists?
  end

  def edit_movie?
    update_movie?
  end

  def update?
    user.member_of?(record.team)
  end
end
