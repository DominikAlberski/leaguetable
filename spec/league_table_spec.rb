require_relative '../league_table.rb'

RSpec.describe LeagueTable do
  it { should respond_to(:matches) }
  it { should respond_to(:get_points).with(1).argument }
  it { should respond_to(:get_goals_for).with(1).argument }
  it { should respond_to(:get_goals_against).with(1).argument }
  it { should respond_to(:get_goal_difference).with(1).argument }
  it { should respond_to(:get_wins).with(1).argument }
  it { should respond_to(:get_draws).with(1).argument }
  it { should respond_to(:get_losses).with(1).argument }

  describe '#matches' do
    it { expect(subject.matches).to respond_to(:push) }
    it 'returns Array' do
      expect(subject.matches.class).to eq(Array)
    end
  end

  describe '#get_points' do
    it 'returnes 0 by default' do
      expect(subject.get_points('team_name')).to eq(0)
    end

    context 'team has 1 win' do
      it 'returnes proper number of points for team' do
        subject.matches.push('team name 1 - 0 sample')
        expect(subject.get_points('team name')).to eq(3)
      end
    end

    context 'team has 2 wins' do
      it 'returnes proper number of points for team' do
        subject.matches.push('team name 1 - 0 sample')
        subject.matches.push('sample 0 - 1 team name')
        expect(subject.get_points('team name')).to eq(6)
      end
    end

    context 'team has 2 wins and 1 draw' do
      it 'returnes proper number of points for team' do
        subject.matches.push('team name 1 - 0 sample')
        subject.matches.push('sample 0 - 1 team name')
        subject.matches.push('sample 0 - 0 team name')
        expect(subject.get_points('team name')).to eq(7)
      end
    end
  end

  describe '#get_goals_for' do
    it 'returnes 0 by default' do
      expect(subject.get_goals_for('team_name')).to eq(0)
    end
    it 'returnes proper number of goals' do
      subject.matches.push('team name 1 - 0 sample')
      subject.matches.push('team name 2 - 0 sample')
      subject.matches.push('sample 1 - 3 team name')
      expect(subject.get_goals_for('team name')).to eq(6)
    end
  end

  describe '#get_goals_against' do
    it 'returnes 0 by default' do
      expect(subject.get_goals_against('team_name')).to eq(0)
    end
    it 'returnes proper number of goals' do
      subject.matches.push('team name 1 - 0 sample')
      subject.matches.push('team name 2 - 0 sample')
      subject.matches.push('sample 1 - 3 team name')
      expect(subject.get_goals_against('team name')).to eq(1)
    end
  end

  describe '#get_goals_against' do
    it 'returnes 0 by default' do
      expect(subject.get_goal_difference('team_name')).to eq(0)
    end
    it 'returnes proper number of goals' do
      subject.matches.push('team name 1 - 0 sample')
      subject.matches.push('team name 2 - 0 sample')
      subject.matches.push('sample 1 - 3 team name')
      expect(subject.get_goal_difference('team name')).to eq(5)
    end
  end

  describe '#get_wins' do
    it 'returnes 0 by default' do
      expect(subject.get_wins('team_name')).to eq(0)
    end
    it 'returnes proper number of wins' do
      subject.matches.push('team name 1 - 0 sample')
      subject.matches.push('team name 2 - 0 sample')
      subject.matches.push('sample 1 - 3 team name')
      expect(subject.get_wins('team name')).to eq(3)
    end
  end

  describe '#get_draws' do
    it 'returnes 0 by default' do
      expect(subject.get_draws('team_name')).to eq(0)
    end
    it 'returnes proper number of draws' do
      subject.matches.push('team name 1 - 0 sample')
      subject.matches.push('team name 2 - 2 sample')
      subject.matches.push('sample 1 - 1 team name')
      expect(subject.get_draws('team name')).to eq(2)
    end
  end

  describe '#get_losses' do
    it 'returnes 0 by default' do
      expect(subject.get_losses('team_name')).to eq(0)
    end
    it 'returnes proper number of wins' do
      subject.matches.push('team name 1 - 0 sample')
      subject.matches.push('team name 2 - 0 sample')
      subject.matches.push('sample 1 - 3 team name')
      expect(subject.get_losses('team name')).to eq(0)
    end
  end
end
