require 'minitest/autorun'
require 'logger'

require_relative 'old_league_table.rb'

class TestLeagueTable < MiniTest::Test

  def setup
    @lt = LeagueTable.new
    @lt.matches.push('Man Utd 3 - 0 Liverpool')
  end

  def test_new_instance_of_LeagueTable_shuld_return_proper_array_of_strings
    @lt.matches.push('Liverpool 1 - 1 Man Utd')
    assert_equal(2, @lt.matches.size)
    assert_equal('Liverpool 1 - 1 Man Utd', @lt.matches[1])
  end

  def test_get_goals_shuld_return_0_by_default
    assert_equal(0, @lt.get_goals_for('team_name'))
  end

  def test_get_goals_for_shuld_return_proper_nr_of_goals_for_given_team_name
    assert_equal(3, @lt.get_goals_for('Man Utd'))
    assert_equal(0, @lt.get_goals_for('Liverpool'))
    @lt.matches.push('Liverpool 1 - 1 Man Utd')
    assert_equal(4, @lt.get_goals_for('Man Utd'))
    assert_equal(1, @lt.get_goals_for('Liverpool'))
    @lt.matches.push('Liverpool 1 - 1 Man Utd')
    @lt.matches.push('Liverpool 1 - 1 Man Utd')
    assert_equal(6, @lt.get_goals_for('Man Utd'))
    assert_equal(3, @lt.get_goals_for('Liverpool'))
    @lt.matches.push('Man Utd 0 - 1 Totenham')
    assert_equal(6, @lt.get_goals_for('Man Utd'))
    assert_equal(1, @lt.get_goals_for('Totenham'))
  end

  def test_get_goals_against_shuld_return_0_by_default
    assert_equal(0, @lt.get_goals_against('team_name'))
  end

  def test_get_goals_against_shuld_return_nr_of_goals_a_team_has_conceeded
    assert_equal(0, @lt.get_goals_against('Man Utd'))
    @lt.matches.push('Liverpool 1 - 1 Man Utd')
    assert_equal(1, @lt.get_goals_against('Man Utd'))
    @lt.matches.push('Man Utd 0 - 1 Totenham')
    assert_equal(2, @lt.get_goals_against('Man Utd'))
    assert_equal(1, @lt.get_goals_for('Totenham'))
  end

  def test_get_goal_difference_shuld_return_0_by_default
    assert_equal(0, @lt.get_goal_difference('team_name'))
  end

  def test_get_goal_difference_shuld_return_difference_beetwen_team_goals_and_team_goals_conceeded
    assert_equal(-3, @lt.get_goal_difference('Liverpool'))
  end

  def test_get_wins_shuld_return_0_by_default
    assert_equal(0, @lt.get_wins('team_name'))
  end

  def test_get_wins_shuld_return_proper_number_of_wins
    assert_equal(1, @lt.get_wins('Man Utd'))
    @lt.matches.push('Liverpool 1 - 1 Man Utd')
    assert_equal(1, @lt.get_wins('Man Utd'))
    @lt.matches.push('Liverpool 1 - 2 Man Utd')
    assert_equal(2, @lt.get_wins('Man Utd'))
    @lt.matches.push('Liverpool 2 - 1 Man Utd')
    assert_equal(2, @lt.get_wins('Man Utd'))
    @lt.matches.push('Totenham 0 - 2 Man Utd')
    assert_equal(3, @lt.get_wins('Man Utd'))
  end

  def test_get_losses_shuld_return_0_by_default
    assert_equal(0, @lt.get_losses('team_name'))
  end

  def test_get_losses_shuld_return_proper_number_of_losses
    assert_equal(0, @lt.get_losses('Man Utd'))
    @lt.matches.push('Liverpool 1 - 1 Man Utd')
    assert_equal(0, @lt.get_losses('Man Utd'))
    @lt.matches.push('Liverpool 2 - 1 Man Utd')
    assert_equal(1, @lt.get_losses('Man Utd'))
  end

  def test_get_draws_shuld_return_0_by_default
    assert_equal(0, @lt.get_draws('team_name'))
  end

  def test_get_draws_shuld_return_proper_number_of_draws
    assert_equal(0, @lt.get_draws('Man Utd'))
    @lt.matches.push('Liverpool 1 - 1 Man Utd')
    assert_equal(1, @lt.get_draws('Man Utd'))
    @lt.matches.push('Liverpool 2 - 1 Man Utd')
    assert_equal(1, @lt.get_draws('Man Utd'))
    @lt.matches.push('Totenham 1 - 1 Man Utd')
    assert_equal(2, @lt.get_draws('Man Utd'))
  end

  def test_get_points_shuld_return_0_by_default
    assert_equal(0, @lt.get_points('team_name'))
  end

  def test_get_points_shuld_return_proper_number_of_points
    assert_equal(3, @lt.get_points('Man Utd'))
    assert_equal(0, @lt.get_points('Liverpool'))
    @lt.matches.push('Liverpool 1 - 1 Man Utd')
    assert_equal(4, @lt.get_points('Man Utd'))
    assert_equal(1, @lt.get_points('Liverpool'))
    @lt.matches.push('Totenham 1 - 2 Man Utd')
    assert_equal(7, @lt.get_points('Man Utd'))
    assert_equal(0, @lt.get_points('Totenham'))
  end
end
