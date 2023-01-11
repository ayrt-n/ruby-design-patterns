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

# Example of module method of implementing decorators
module TimeStampWriter
  def write_line(line)
    super("#{Time.new}: #{line}")
  end
end

module NumberWriter
  attr_reader :line_number

  def write_line(line)
    @line_number = 1 unless @line_number
    super("#{@line_number}: #{line}")
    @line_number += 1
  end
end

w = SimpleWriter.new('module')
w.extend(NumberWriter)
w.extend(TimeStampWriter)
w.write_line('Hello')
