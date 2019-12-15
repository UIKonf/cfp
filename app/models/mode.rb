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

  RULES = {
    inactive: [],
    cfp: [
      %i[log_in user],
      %i[show user],
      %i[index proposal],
      %i[show proposal],
      %i[new proposal],
      %i[create proposal],
      %i[update proposal],
      %i[edit proposal],
      %i[publish proposal],
      %i[withdraw proposal],
      %i[destroy proposal],
      %i[index comment],
      %i[create comment],
      %i[destroy comment]
    ],
    review: [
      %i[log_in user],
      %i[show user],
      %i[index proposal],
      %i[show proposal],
      %i[edit proposal],
      %i[update proposal],
      %i[withdraw proposal],
      %i[destroy proposal],
      %i[index comment],
      %i[create comment],
      %i[destroy comment]
    ],
    hold: [
      %i[log_in user],
      %i[show user],
      %i[index proposal],
      %i[show proposal],
      %i[withdraw proposal],
      %i[destroy proposal],
      %i[destroy comment]
    ],
    selection: [
      %i[log_in user],
      %i[show user],
      %i[index proposal],
      %i[show proposal],
      %i[withdraw proposal],
      %i[destroy proposal],
      %i[index selection],
      %i[create selection],
      %i[destroy selection],
      %i[destroy comment]
    ],
    archive: [
      %i[log_in user],
      %i[show user],
      %i[index proposal],
      %i[show proposal],
      %i[withdraw proposal],
      %i[destroy proposal],
      %i[index selection],
      %i[destroy comment]
    ]
  }.freeze
end
