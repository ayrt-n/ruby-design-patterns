# frozen_string_literal: true

# The Observer Pattern

# Employee Class
class Employee
  attr_reader :name, :salary
  attr_accessor :title

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
    @observers = []
  end

  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each { |observer| observer.update(self) }
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
