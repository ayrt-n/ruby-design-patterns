# frozen_string_literal: true

# The Template Pattern
# If you want to vary an algorithm, one way to do so is to code the invariant
# part in a base class and to encapsulate the variable parts in methods that are
# defined by a number of subclasses

# The base class can simply leave the methods undefined, in which case the sub
# class must spply the method, or the base class may provide a default
# implementation for the method which sub classes may override

# Abstract Report Class
class Report
  def initialize
    @title = 'Monthly Report'
    @text = ['Things are going,', 'really, really well.']
  end

  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  def output_body
    @text.each { |line| output_line(line) }
  end

  def output_start; end

  def output_head
    raise 'Called abstract method: output_head'
  end

  def output_body_start; end

  def output_line(_line)
    raise 'Called abstract method: output_line'
  end

  def output_body_end; end

  def output_end; end
end

# Concrete HTMLReport Subclass
class HTMLReport < Report
  def output_start
    puts '<html>'
  end

  def output_head
    puts '  <head>'
    puts "    <title>#{@title}</title>"
    puts '  </head>'
  end

  def output_body_start
    puts '  <body>'
  end

  def output_line(line)
    puts "    <p>#{line}</p>"
  end

  def output_body_end
    puts '  </body>'
  end

  def output_end
    puts '</html>'
  end
end

# Concrete PlainTextReport Subclass
class PlainTextReport < Report
  def output_head
    puts "*** #{@title} ***"
  end

  def output_line(line)
    puts line
  end
end

# Example
report = HTMLReport.new
report.output_report

report = PlainTextReport.new
report.output_report
