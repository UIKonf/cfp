module Cfp
  def self.mode
    @mode ||= Mode.new(ENV['CFP_MODE'].to_sym)
  end

  def self.mode=(new_mode)
    @mode = if new_mode.nil?
              Mode.new
            else
              Mode.new(new_mode.to_sym)
            end
  end
end
