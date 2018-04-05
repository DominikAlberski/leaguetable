class LeagueTable
  attr_accessor :matches
  def initialize
    @matches = []
    @match_counter = 0
    @teams_names_goals = {}
    @teams_names_goals_lost = {}
    @teams_names_wins = {}
    @teams_names_losses = {}
    @teams_names_draws = {}
  end

  def get_goals_for(team_name)
    check_matches
    return 0 unless @teams_names_goals.include?(team_name)
    @teams_names_goals[team_name]
  end

  def get_goals_against(team_name)
    check_matches
    return 0 unless @teams_names_goals_lost.include?(team_name)
    @teams_names_goals_lost[team_name]
  end

  def get_goal_difference(team_name)
    check_matches
    return 0 unless @teams_names_goals.include?(team_name)
    get_goals_for(team_name) - get_goals_against(team_name)
  end

  def get_wins(team_name)
    check_matches
    return 0 unless @teams_names_wins.include?(team_name)
    @teams_names_wins[team_name]
  end

  def get_losses(team_name)
    check_matches
    return 0 unless @teams_names_losses.include?(team_name)
    @teams_names_losses[team_name]
  end

  def get_draws(team_name)
    check_matches
    return 0 unless @teams_names_draws.include?(team_name)
    @teams_names_draws[team_name]
  end

  def get_points(team_name)
    check_matches
    return 0 unless @teams_names_goals.include?(team_name)
    points_for_win = 3
    points_for_draw = 1
    get_wins(team_name) * points_for_win + get_draws(team_name) * points_for_draw
  end

  private

  def check_matches
    while @match_counter != @matches.size
      parse_match
      @match_counter += 1
    end
  end

  def parse_match
    teams = matches[@match_counter].split(' - ')
    home_team = teams[0].split(' ')
    home_team_name = home_team[0..-2].join(' ')
    home_team_goals = home_team[-1].to_i
    away_team = teams[1].split(' ', 2)
    away_team_name = away_team[-1]
    away_team_goals = away_team[0].to_i
    set_team_goals(home_team_name, away_team_name, home_team_goals, away_team_goals)
    set_team_wins_loss_draws(home_team_name, away_team_name, home_team_goals, away_team_goals)
  end

  def set_team_goals(home_team_name, away_team_name, home_team_goals, away_team_goals)
    @teams_names_goals[home_team_name] ||= 0
    @teams_names_goals[home_team_name] += home_team_goals
    @teams_names_goals[away_team_name] ||= 0
    @teams_names_goals[away_team_name] += away_team_goals
    @teams_names_goals_lost[home_team_name] ||= 0
    @teams_names_goals_lost[home_team_name] += away_team_goals
    @teams_names_goals_lost[away_team_name] ||= 0
    @teams_names_goals_lost[away_team_name] += home_team_goals
  end

  def set_team_wins_loss_draws(home_team_name, away_team_name, home_team_goals, away_team_goals)
    if home_team_goals > away_team_goals
      @teams_names_wins.include?(home_team_name) ? @teams_names_wins[home_team_name] += 1 : @teams_names_wins[home_team_name] = 1
      @teams_names_losses.include?(away_team_name) ? @teams_names_losses[away_team_name] += 1 : @teams_names_losses[away_team_name] = 1
    elsif home_team_goals < away_team_goals
      @teams_names_wins.include?(away_team_name) ? @teams_names_wins[away_team_name] += 1 : @teams_names_wins[away_team_name] = 1
      @teams_names_losses.include?(home_team_name) ? @teams_names_losses[home_team_name] += 1 : @teams_names_losses[home_team_name] = 1
    else
      @teams_names_draws.include?(home_team_name) ? @teams_names_draws[home_team_name] +=1 : @teams_names_draws[home_team_name] = 1
      @teams_names_draws.include?(away_team_name) ? @teams_names_draws[away_team_name] +=1 : @teams_names_draws[away_team_name] = 1
    end
  end
end
