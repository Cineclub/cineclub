class RoundPolicy < ApplicationPolicy
  def create_screening?
    user.member_of?(record.team)
  end

  def update_movie?
    true # TODO: User in team && no screenings yet
  end

  def edit_movie?
    update_movie?
  end
end
