# frozen_string_literal: true

# Example of adaptive adapter where we do not need to create a new adapter class
# but simply load in the class we need to modify and alter the interface of
# the original class. Helpful when the class to be adapted is very similar
# to the interface we want but slightly different (see below)

# Lean towards modifying class directly in situations where the modification are simple and clear
# and you understand the class and how it is used.

# Class for standard text object
class TextObject
  attr_reader :text, :size, :color

  def initialize(text, size, color)
    @text = text
    @size = size
    @color = color
  end
end

# Class to render text object to screen
class Renderer
  def render(text_object)
    text = text_object.text
    size = text_object.size
    color = text_object.color

    # code to render the text object
  end
end

# Assume BritishTextObject is from another file and we load it in using:
# require 'british_text_object'
class BritishTextObject
  # From the original class, slight differences in variable naming but same concepts
  attr_reader :string, :size_mm, :colour

  def initialize(string, size_mm, colour)
    @string = string
    @size_mm = size_mm
    @colour = colour
  end

  # New methods added to the original class
  def text
    string
  end

  def color
    colour
  end

  def size_inches
    size_mm / 25.4
  end
end

# Instead of modifying the whole class, could also use a Singleton like so...
# (Assume the original BritishTextObject has not been modified as above)
bto = BritishTextObject.new('hello', 50.8, :blue)

class << bto
  def text
    string
  end

  def color
    colour
  end

  def size_inches
    size_mm / 25.4
  end
end
