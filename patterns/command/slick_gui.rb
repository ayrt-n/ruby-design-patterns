# frozen_string_literal: true

# The Command Pattern

# SlickButton Class
class SlickButton
  attr_accessor :command

  def initialize(command)
    @command = command
  end

  #
  # Lots of button drawing and mgmt code
  #

  def on_button_push
    @command&.execute
  end
end

# Example Concrete Command Object
class SaveCommand
  def execute
    #
    # Save the document code
    #
  end
end

# Example Code
# save_button = SlickButton.new(SaveCommand.new)