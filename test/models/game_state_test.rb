# frozen_string_literal: true

require 'test_helper'

class GameStateTest < ActiveSupport::TestCase
  setup do
    winning_team = Team.new
    losing_team = Team.new

    user_1 = GameUser.new(user: User.new(name: "1"), team: winning_team)
    user_2 = GameUser.new(user: User.new(name: "2"), team: winning_team)
    user_3 = GameUser.new(user: User.new(name: "3"), team: winning_team)
    user_4 = GameUser.new(user: User.new(name: "4"), team: losing_team)
    user_5 = GameUser.new(user: User.new(name: "5"), team: losing_team)
    user_6 = GameUser.new(user: User.new(name: "6"), team: losing_team)

    @teams = [winning_team, losing_team]
    @game = GameState.new(teams: @teams, settings: Game.new)

    @round_conclusion  = GameState::RoundConclusion.new(
      dragon_head: user_1, 
      dragon_tails: [user_4, user_5, user_6],
    )
  end

  test '#initialize pulls in initial score card rank from game' do
    assert_equal @game.initial_score_card_rank, Game.new.initial_score_card_rank
  end

  test '#initialize pulls in terminating score card rank from game' do
    assert_equal @game.terminating_score_card_rank, Game.new.terminating_score_card_rank
  end

  test 'begins in awaiting_players state' do
    assert @game.awaiting_players?
  end

  test 'once players have all arrived, state moves to in_progress' do
    @game.players_set
    assert @game.round_in_progress?
  end

  test '#round_finished increments the round' do
    @game.players_set

    assert_equal 0, @game.round
    @game.round_finished(round_conclusion: @round_conclusion)
    assert_equal 1, @game.round
    assert_predicate @game, :round_in_progress?
  end

  test '#round_finished results in a completed game if the terminating score card rank is reached' do
    settings = Game.new
    settings.terminating_score_card_rank = 3
    settings.initial_score_card_rank = 2
    @game = GameState.new(teams: @teams, settings: settings)

    @game.players_set
    refute_predicate @game, :conclusion?

    @game.round_finished(round_conclusion: @round_conclusion)
    assert_predicate @game, :conclusion?
  end
end
