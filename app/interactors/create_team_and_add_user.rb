require 'hanami/interactor'

class CreateTeamAndAddUser
  include Hanami::Interactor

  expose :team

  def call(user:, team_name:)
    @team = Team.new(
      name: team_name,
      users: [user]
    )

    @team.errors.full_messages.each { |msg| error(msg) } unless @team.save
  end
end
