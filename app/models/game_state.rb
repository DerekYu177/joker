# frozen_string_literal: true

class GameState
  attr_reader :initial_score_card_rank, :terminating_score_card_rank, :round

  RoundConclusion = Struct.new(:dragon_head, :dragon_tails, keyword_init: true)

  state_machine :state, initial: :awaiting_players do 
    event :players_set do
      transition awaiting_players: :round_in_progress
    end

    state :round_in_progress do
    end

    state :conclusion do
    end

    event :round_finished do
      transition round_in_progress: :conclusion, if: :terminating_game?
      transition round_in_progress: same
    end
    before_transition on: :round_finished, do: :round_complete
  end

  def initialize(teams:, settings:)
    @teams = teams

    @initial_score_card_rank = settings.initial_score_card_rank
    @terminating_score_card_rank = settings.terminating_score_card_rank 

    @teams.each do |team|
      team.current_score_card_rank = @initial_score_card_rank
    end

    @round = 0

    super()
  end

  def round_complete
    @round += 1
    # redistribute cards etc.
  end

  def terminating_game?
    @teams.any? { |team| team.current_score_card_rank >= terminating_score_card_rank } 
  end

  def round_finished(round_conclusion:)
    round_conclusion.dragon_head.team.current_score_card_rank += 1
    
    # call #round_won_by instead!
    super()
  end
end
