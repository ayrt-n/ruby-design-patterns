# frozen_string_literal: true

# The Command Pattern
# With the command pattern, we construct objects that know how to perform
# some very specific actions. In Ruby, we are able to use the command
# pattern through concrete command classes or via code blocks (see _proc.rb
# for example). Additionally, combined with the composite pattern, you can
# queue commands, keep track of, and reverse commands if needed (see file_
# command.rb for example)

# Be careful not to use the command pattern when you can simply write out
# the command and avoid useless boilerplate. Make sure that you really need
# the command pattern before using!

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
