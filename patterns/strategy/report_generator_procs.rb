# frozen_string_literal: true

# The Strategy Pattern using Procs instead of objects

# Report Class
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = 'Monthly Report'
    @text = ['Things are going,', 'really, really well.']
    @formatter = formatter
  end

  def output_report
    @formatter.call(self)
  end
end

# Concrete HTMLReport Subclass
HTML_FORMATTER = lambda do |context|
  puts '<html>'
  puts '  <head>'
  puts "    <title>#{context.title}</title>"
  puts '  </head>'
  puts '  <body>'
  context.text.each { |line| puts "      <p>#{line}</p>"}
  puts '  </body>'
  puts '</html>'
end

# Concrete PlainTextReport Subclass
PLAIN_TEXT_FORMATTER = lambda do |context|
  puts "*** #{context.title} ***"
  context.text.each { |line| puts line }
end

report = Report.new(&HTML_FORMATTER)
report.output_report
report.formatter = PLAIN_TEXT_FORMATTER
report.output_report
