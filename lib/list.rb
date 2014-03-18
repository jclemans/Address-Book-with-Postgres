require 'task'

class List
  attr_reader :list_name, :id

  def initialize(list_name, id)
    @list_name = list_name
    @id = id
  end

  def ==(another_list)
    self.list_name == another_list.list_name
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      list_name = result['list_name']
      id = result['id'].to_i
      lists << List.new(list_name, id)
    end
    lists
  end

  def save
    results = DB.exec("INSERT INTO lists (list_name) VALUES ('#{@list_name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def return_tasks(query_name)
    tasks = []
    results = DB.exec("SELECT * FROM tasks WHERE ('#{@list_name}' = '#{query_name}');")
    results.each do |result|
      task_name = result['task_name']
      id = result['id'].to_i
      tasks << task_name
    end
    tasks
  end

end
