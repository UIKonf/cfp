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
      %i[view user],
      %i[view proposal],
      %i[create proposal],
      %i[update proposal],
      %i[publish proposal],
      %i[withdraw proposal],
      %i[destroy proposal],
      %i[create comment],
      %i[hide comment]
    ],
    review: [
      %i[log_in user],
      %i[view user],
      %i[view proposal],
      %i[update proposal],
      %i[withdraw proposal],
      %i[destroy proposal],
      %i[create comment],
      %i[hide comment]
    ],
    holding: [
      %i[log_in user],
      %i[view user],
      %i[view proposal],
      %i[withdraw proposal],
      %i[destroy proposal]
    ],
    voting: [
      %i[log_in user],
      %i[view user],
      %i[view proposal],
      %i[withdraw proposal],
      %i[destroy proposal],
      %i[view selection],
      %i[create selection],
      %i[destroy selection]
    ],
    archive: [
      %i[log_in user],
      %i[view user],
      %i[view proposal],
      %i[withdraw proposal],
      %i[destroy proposal],
      %i[view selection]
    ]
  }.freeze
end
