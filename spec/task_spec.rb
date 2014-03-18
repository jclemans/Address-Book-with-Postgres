require 'rspec'
require 'task'
require 'pg'

DB = PG.connect({:dbname => 'to_do_test'})
RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do
  describe 'initialize' do
    it 'is initialized with a task name and a list ID' do
      test_task = Task.new('ride a unicorn', 1)
      test_task.should be_an_instance_of Task
    end

    it 'tells you its name' do
      task = Task.new('learn SQL', 1)
      task.task_name.should eq 'learn SQL'
    end

    it 'tells you its list ID' do
      task = Task.new('learn SQL', 1)
      task.list_id.should eq 1
    end

    it 'starts off with no tasks' do
      Task.all.should eq []
    end

    it 'lets you save tasks to the database' do
      task = Task.new('learn SQL', 1)
      task.save
      Task.all.should eq [task]
    end

    it 'is the same task if it has the same name' do
      task1 = Task.new('Do stuff', 1)
      task2 = Task.new('Do stuff', 1)
      task1.should eq task2
    end
  end

  describe 'delete' do
    it 'removes a single task from the database' do
      list = List.new('Finished stuff', 1)
      list.save
      task = Task.new('Delete me!', list.id)
      task.save
      task.delete('Delete me!').should eq nil
    end
  end
end
