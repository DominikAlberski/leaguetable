class LeagueTable
  attr_accessor :matches
  def initialize
    @matches = []
  end

  def get_points(team_name)
    team = parse(team_name)
    team ? team.points : 0
  end

  def get_goals_for(team_name)
    team = parse(team_name)
    team ? team.goals.sum : 0
  end

  def get_goals_against(team_name)
    team = parse(team_name)
    team ? team.goals_against.sum : 0
  end

  def get_goal_difference(team_name)
    get_goals_for(team_name) - get_goals_against(team_name)
  end

  def get_wins(team_name)
    team = parse(team_name)
    team ? team.wins_losses.count(true) : 0
  end

  def get_draws(team_name)
    team = parse(team_name)
    team ? team.draws.count(true) : 0
  end

  def get_losses(team_name)
    team = parse(team_name)
    team ? team.wins_losses.count(false) : 0
  end

  private

  def parse(team_name)
    MatchesParser.new.for(team_name, matches)
  end
end

class MatchesParser
  def for(team_name, matches)
    parse(matches, team_name)
  end

  def parse(matches, team_name)
    team_hash = {}
    matches.flat_map do |match|
      match.scan(/(\D*) (\d*) - (\d*) (\D*)/)
    end.each do |array|
      team_hash[array[0]] ||= Team.new(array[0])
      team_hash[array[0]].add_goals(array[1].to_i)
      team_hash[array[0]].add_goals_against(array[2].to_i)
      team_hash[array[0]].add_wins_losses(array[1, 2].map(&:to_i))
      team_hash[array[0]].add_draws(array[1, 2].map(&:to_i))
      team_hash[array[-1]] ||= Team.new(array[-1])
      team_hash[array[-1]].add_goals(array[2].to_i)
      team_hash[array[-1]].add_goals_against(array[1].to_i)
      team_hash[array[-1]].add_wins_losses(array[1, 2].reverse.map(&:to_i))
      team_hash[array[-1]].add_draws(array[1, 2].reverse.map(&:to_i))
    end
    team_hash[team_name]
  end
end

class Team
  attr_reader :team_name, :goals, :goals_against, :wins_losses, :draws
  def initialize(team_name)
    @team_name = team_name
    @goals = []
    @goals_against = []
    @wins_losses = []
    @draws = []
  end

  def points
    @wins_losses.count(true) * 3 + @draws.count(true)
  end

  def add_goals(num)
    @goals << num
  end

  def add_goals_against(num)
    @goals_against << num
  end

  def add_wins_losses(arr)
    @wins_losses << win?(arr)
  end

  def add_draws(arr)
    @draws << draw?(arr)
  end

  def win?(array)
    array[0] > array[1] ? true : false
  end

  def draw?(array)
    array[0] == array[1] ? true : false
  end
end
