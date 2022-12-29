# frozen_string_literal: true

# The Command Pattern (using Procs)

# SlickButton Class
class SlickButton
  attr_accessor :command

  def initialize(&block)
    @command = block
  end

  #
  # Lots of button drawing and mgmt code
  #

  def on_button_push
    @command&.call
  end
end

# Example Code
# new_button = SlickButton.new do
#   #
#   # Code to do some command
#   #
# end
