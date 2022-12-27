# frozen_string_literal: true

require_relative './subject'

# The Observer Pattern

# Employee Class
class Employee
  include Subject

  attr_reader :salary
  attr_accessor :name, :title

  def initialize(name, title, salary)
    super()
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end
end

# Example code
fred = Employee.new('Fred', 'Crane Operator', 30_000.0)
fred.add_observer do |changed_employee|
  puts "#{changed_employee.name}'s new salary is #{changed_employee.salary}"
end

fred.salary = 35_000.0
