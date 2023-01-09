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

# Example code
reader = File.open('./adapter/message.txt')
writer = File.open('./adapter/message.encrypted', 'w')
encrypter = Encrypter.new('my secret key')
encrypter.encrypt(reader, writer)
