class TeamsController < ApplicationController
  before_action :require_login, only: %i[join leave]
  before_action :set_team, only: %i[show edit update join leave]

  def index
    @teams = Team.all
  end

  def show; end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    service = CreateTeamAndAddUser.new
    result = service.call(user: current_user, team_name: team_params[:name])

    if result.success?
      redirect_to @team, notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  def join
    authorize @team

    if @team.users << current_user
      redirect_to @team, notice: 'Team was successfully joined.'
    else
      render :show
    end
  end

  def leave
    if @team.users.delete(current_user)
      redirect_to @team, notice: 'Team was successfully abandoned.'
    else
      render :show
    end
  end

  private

  def team_params
    params.require(:team).permit(
      :name
    )
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
