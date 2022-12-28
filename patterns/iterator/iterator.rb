# frozen_string_literal: true

# The Iterator Pattern

# External Iterator
class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next_item
    value = item
    @index += 1
    value
  end
end

# Example of merging two sorted arrays using external iterator
def merge(array1, array2)
  merged = []

  iterator1 = ArrayIterator.new(array1)
  iterator2 = ArrayIterator.new(array2)

  while iterator1.has_next? && iterator2.has_next?
    if iterator1.item < iterator2.item
      merged << iterator1.next_item
    else
      merged << iterator2.next_item
    end
  end

  merged << iterator1.next_item while iterator1.has_next?
  merged << iterator2.next_item while iterator2.has_next?

  merged
end

# Example using Internal Iterator (with built-in Ruby Enumerable mixin)
# To add enumerable method, need an internal iterator method named each
# and a reasonable implementation of the <=> comparison operator

# By mixing in enumerable, enables easy use of handy Ruby built-in methods (see below)

# Account Class
class Account
  attr_accessor :name, :balance

  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def <=>(other)
    balance <=> other.balance
  end
end

# Portfolio Class with Enumerable Mixin
class Portfolio
  include Enumerable

  def initialize
    @accounts = []
  end

  def each(&block)
    @accounts.each(&block)
  end

  def add_account(account)
    @accounts << account
  end
end

# Example of how Portfolio enumerable methods now work
portfolio = Portfolio.new
portfolio.add_account(Account.new('Trading', 2000.0))
portfolio.add_account(Account.new('Long-term', 15_000.0))
portfolio.add_account(Account.new('Yolo fund', -50_000.0))

puts(portfolio.any? { |account| account.balance > 2000 }) 
puts(portfolio.all? { |account| account.balance >= 0 })
