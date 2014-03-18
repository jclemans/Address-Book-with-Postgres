require 'pg'



class Task
  attr_reader :task_name, :list_id, :results

   def initialize(task_name, list_id)
    @task_name = task_name
    @list_id = list_id
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      task_name = result['task_name']
      list_id = result['list_id'].to_i
      tasks << Task.new(task_name, list_id)
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (task_name, list_id) VALUES ('#{@task_name}', '#{@list_id}');")
  end

  def ==(another_task)
    self.task_name == another_task.task_name && self.list_id == another_task.list_id
  end

  def delete(targeted_delete)
    DB.exec("DELETE FROM tasks WHERE task_name = ('#{targeted_delete}')")
  end
end

