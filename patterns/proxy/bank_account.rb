# frozen_string_literal: true

# The Proxy Pattern


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
