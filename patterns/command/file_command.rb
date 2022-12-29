# frozen_string_literal: true

# The Command Pattern (with state information)

# Base Command Object
class Command
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute; end
end

# Class to Create File
class CreateFile < Command
  def initialize(path, contents)
    super("Create file: #{path}")
    @path = path
    @contents = contents
  end

  def execute
    f = File.open(@path, 'w')
    f.write(@contents)
    f.close
  end
end

# Class to Delete File
class DeleteFile < Command
  def initialize(path)
    super("Delete file: #{path}")
    @path = path
  end

  def execute
    File.delete(@path)
  end
end

# Class to Copy File
class CopyFile < Command
  def initialize(source, target)
    super("Copy file: #{source} to #{target}")
    @source = source
    @target = target
  end

  def execute
    FileUtils.copy(@source, @target)
  end
end

# Combining Composite Pattern to collect and keep track of all commands
class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def add_command(cmd)
    @commands << cmd
  end

  def execute
    @commands.each { |cmd| cmd.execute }
  end

  def description
    description = ''
    @commands.each { |cmd| description += "#{cmd.description}\n" }
    description
  end
end

# Example Code
# cmds = CompositeCommand.new

# cmds.add_command(CreateFile.new('file1.txt', "Hello world\n"))
# cmds.add_command(CopyFile.new('file1.txt', 'file2.txt'))
# cmds.add_command(DeleteFile.new('file1.txt'))

# puts cmds.description
# cmds.execute
