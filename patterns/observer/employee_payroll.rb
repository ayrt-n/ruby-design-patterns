# frozen_string_literal: true

require 'observer'

# The Observer Pattern
# Allows you to build components that know about activities of other components
# without having to tightly couple everything together. Used by creating an interface
# between the source of news (observable/subject) and the consumer of news (observers)

# Observer pattern has similarities to the Strategy pattern, however, main difference
# is in the intent. Observer wants to inform other objects of events happening, while
# in the case of the Strategy pattern, we want the strategy object to do some computing
# for us

# Employee Class
class Employee
  include Observable

  attr_reader :name, :salary
  attr_accessor :title

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    old_salary = @salary
    @salary = new_salary
    if old_salary != new_salary
      changed
      notify_observers(self)
    end
  end
end

# Payroll Class
class Payroll
  def update(changed_employee)
    puts "#{changed_employee.name}'s new salary is #{changed_employee.salary}"
  end
end

# Taxman Class
class Taxman
  def update(changed_employee)
    puts "Send #{changed_employee.name} a new tax bill!"
  end
end

# Example code
fred = Employee.new('Fred', 'Crane Operator', 30_000.0)
payroll = Payroll.new
taxman = Taxman.new

fred.add_observer(payroll)
fred.add_observer(taxman)

fred.salary = 35_000.0
