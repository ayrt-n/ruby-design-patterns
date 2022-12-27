# frozen_string_literal: true

require 'observer'

# The Observer Pattern

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
