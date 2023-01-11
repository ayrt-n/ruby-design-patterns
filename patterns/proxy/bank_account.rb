# frozen_string_literal: true

# The Proxy Pattern
# Proxices can help solve a number of problems. The examples below
# focus on protecting an object from unauthorized access, hiding the fact the
# object lives somewhere else on the network, and delaying the creation of
# an expensive object until the last instant.Proxies pretend to be some
# other object but are not and instead include a hidden reference to the
# real object referred to as the subject.

# In short, a proxy can control access to the subject, while keeping the
# logic separate from the subject itself. The proxy can implement the
# methods themselves directly or use method_missing (as in example below).


# Class representation of Bank Account
# The real object/subject in proxy example
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

# Most basic proxy for BankAccount
class BankAccountProxy
  def initialize(real_account)
    @subject = real_account
  end

  def method_missing(name, *args)
    @subject.send(name, *args)
  end
end

# Example of implementation a protection proxy
require 'etc'

# Protection proxy class
class AccountProctionProxy
  def initialize(real_account, owner_name)
    @subject = real_account
    @owner_name = owner_name
  end

  def method_missing(name, *args)
    check_access
    @subject.send(name, *args)
  end

  def check_access
    raise "Illegal access: #{Etc.getlogin} cannot access account" if Etc.getlogin != @owner_name
  end
end

# Example of implementation of virtual proxy
# Virtual proxy class
class VirtualAccountProxy
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def method_missing(name, *args)
    s = subject
    s.send(name, *args)
  end

  def subject
    @subject || (@subject = @creation_block.call)
  end
end

# Example of how to use virtual proxy
account = VirtualAccountProxy.new { BankAccount.new(10) }
account.deposit(10)
