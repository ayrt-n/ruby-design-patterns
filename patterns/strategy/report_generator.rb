# frozen_string_literal: true

# The Strategy Pattern

# Report Class
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = 'Monthly Report'
    @text = ['Things are going,', 'really, really well.']
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(@title, @text)
  end
end

# Abstract Formatter Class
class Formatter
  def output_report(title, text)
    raise 'Abstract method called'
  end
end

# Concrete HTMLReport Subclass
class HTMLFormatter < Formatter
  def output_report(title, text)
    puts '<html>'
    puts '  <head>'
    puts "    <title>#{title}</title>"
    puts '  </head>'
    puts '  <body>'
    text.each { |line| puts "      <p>#{line}</p>"}
    puts '  </body>'
    puts '</html>'
  end
end

# Concrete PlainTextReport Subclass
class PlainTextFormatter < Formatter
  def output_report(title, text)
    puts "*** #{title} ***"
    text.each { |line| puts line }
  end
end

# Example Code
report = Report.new(HTMLFormatter.new)
report.output_report
report.formatter = PlainTextFormatter.new
report.output_report