# frozen_string_literal: true

# The Adapter Pattern

# Class which encrypts file
class Encrypter
  def initialize(key)
    @key = key
  end

  def encrypt(reader, writer)
    key_index = 0
    until reader.eof?
      clear_char = reader.getc
      encrypted_char = clear_char.ord ^ (@key[key_index].ord)
      writer.putc(encrypted_char)
      key_index = (key_index + 1) % @key.size
    end
  end
end

# String IO Adapter Class
class StringIOAdapter
  def initialize(string)
    @string = string
    @position = 0
  end

  def getc
    raise EOFError if @position >= @string.length

    @position += 1
    @string[@position - 1]
  end

  def eof?
    @position >= @string.length
  end
end

# Example code using a file
reader = File.open('./adapter/message.txt')
writer = File.open('./adapter/message_encrypted.txt', 'w')
encrypter = Encrypter.new('my secret key')
encrypter.encrypt(reader, writer)

# Example code using our adapter
encrypter = Encrypter.new('XYZZY')
reader = StringIOAdapter.new('We attack at dawn')
writer = File.open('./adapter/out.txt', 'w')
encrypter.encrypt(reader, writer)
