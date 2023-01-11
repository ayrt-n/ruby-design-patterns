# frozen_string_literal: true

# Example of method wrapping technique, useful for simple decorators
# (However, not useful for more complex, due to potential name collisions)

require_relative './writer'

w = SimpleWriter.new('out')

class << w
  alias old_write_line write_line

  def write_line(line)
    old_write_line("#{Time.new}: #{line}")
  end
end

w.write_line('Timestamp!!')
