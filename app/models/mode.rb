# frozen_string_literal: true

class Mode
  attr_reader :mode

  def initialize(mode = :cfp)
    @mode = if RULES.key?(mode)
              mode
            else
              :cfp
            end
  end

  def can?(action, object)
    RULES[mode].include?([action, object])
  end

  def self.mode_for(hash)
    hash.reduce([]) { |acc, (object, actions)| acc + actions.map { |action| [action, object] } }
  end

  RULES = {
    inactive: [],
    cfp: mode_for(user: %i[log_in show],
                  proposal: %i[index show new create update edit publish withdraw destroy],
                  comment: %i[index create destroy]),
    review: mode_for(user: %i[log_in show],
                     proposal: %i[index show update edit withdraw destroy],
                     comment: %i[index create destroy]),
    hold: mode_for(user: %i[log_in show],
                   proposal: %i[index show withdraw destroy],
                   comment: %i[destroy]),
    selection: mode_for(user: %i[log_in show],
                        proposal: %i[index show withdraw destroy],
                        comment: %i[destroy],
                        selection: %i[index create destroy]),
    archive: mode_for(user: %i[log_in show],
                      proposal: %i[index show withdraw destroy],
                      comment: %i[destroy],
                      selection: %i[index])
  }.freeze

end
