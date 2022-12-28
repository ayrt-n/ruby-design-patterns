# frozen_string_literal: true

# The Composite Pattern

# Useful when you are trying to build a hierarchy or tree of objects and you
# do not want the code that uses the tree to constantly have to worry about
# whether it is dealing with a single object or a whole branch

# Component Base Class
class Task
  attr_reader :name
  attr_accessor :parent

  def initialize(name)
    @name = name
    @parent = nil
  end

  def get_time_required
    0.0
  end

  def total_number_of_basic_tasks
    1
  end
end

# Leaf Class
class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end

  def get_time_required
    1.0
  end
end

# Leaf Class
class AddLiquidsTask < Task
  def initialize
    super('Add wet ingredients')
  end

  def get_time_required
    1.0
  end
end

# Leaf Class
class MixTask < Task
  def initialize
    super('Mix the batter')
  end

  def get_time_required
    3.0
  end
end

# Base Composite Class
class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks << task
    task.parent = self
  end

  def <<(task)
    add_sub_task(task)
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
    task.parent = nil
  end

  def [](index)
    @sub_tasks[index]
  end

  def get_time_required
    @sub_tasks.reduce(0) { |total, task| total + task.get_time_required }
  end

  def total_number_of_basic_tasks
    @sub_tasks.reduce(0) { |total, task| total + task.total_number_of_basic_tasks }
  end
end

# Concrete Composite Class
class MakeBatterTask < CompositeTask
  def initialize
    super('Make batter')
    @sub_tasks = []

    add_sub_task(AddDryIngredientsTask.new)
    add_sub_task(AddLiquidsTask.new)
    add_sub_task(MixTask.new)
  end
end

# Example Code
make_batter = MakeBatterTask.new
puts make_batter.get_time_required
puts make_batter.total_number_of_basic_tasks
