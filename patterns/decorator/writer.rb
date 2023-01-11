# frozen_string_literal: true

# The Decorator Pattern
# Helpful in assembling the exact functionality that you need at runtime and offers
# alternative to creating monolithic object which supports every single feature.
# To use, create one class with the basic functionality and a set of decorators
# to go with it. Each decorator implements the core interface, but adds its own
# twist. Each decorator takes a method call, adds its own twist, and then passes
# it on to the next component down the line (decorator or the real component).

# Class to write plan text
class SimpleWriter
  def initialize(path)
    @file = File.open(path, 'w')
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end

# Base decorator class
class WriterDecorator
  def initialize(real_writter)
    @real_writter = real_writter
  end

  def write_line(line)
    @real_writter.write_line(line)
  end

  def pos
    @real_writter.pos
  end

  def rewind
    @real_writter.rewind
  end

  def close
    @real_writter.close
  end
end

# Alternative implementation of base decorator using forwardable module
# require 'forwardable'

# # Base decorator class
# class WriterDecorator
#   extend Forwardable

#   def_delegators :@real_writter, :write_line, :rewind, :pos, :close

#   def initialize(real_writter)
#     @real_writter = real_writter
#   end
# end

# Decorator class
class NumberingWriter < WriterDecorator
  def initialize(real_writter)
    super(real_writter)
    @line_number = 1
  end

  def write_line(line)
    @real_writter.write_line("#{@line_number}: #{line}")
    @line_number += 1
  end
end

# Decorator class
class CheckSummingWritter < WriterDecorator
  attr_reader :check_sum

  def initialize(real_writter)
    super(real_writter)
    @check_sum = 0
  end

  def write_line(line)
    line.each_byte { |byte| @check_sum = (@check_sum + byte) % 256 }
    @check_sum += "\n"[0].ord % 256
    @real_writter.write_line(line)
  end
end

# Decorator class
class TimeStampingWriter < WriterDecorator
  def write_line(line)
    @real_writter.write_line("#{Time.new}: #{line}")
  end
end

# Example code
writer = CheckSummingWritter.new(
  TimeStampingWriter.new(
    SimpleWriter.new('final.txt')
  )
)

writer.write_line('Hello out there')
