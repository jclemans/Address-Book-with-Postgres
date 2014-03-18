require 'rspec'
require 'pg'
require 'list'

DB = PG.connect({:dbname => 'to_do_test'})
RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
  end
end

describe List do
  describe 'initialize' do
    it 'is initialized with a new name' do
      list = List.new('Epicodus stuff', 1)
      list.should be_an_instance_of List
    end

    it 'can be initialized with its database ID' do
      list = List.new('Epicodus stuff', 1)
      list.should be_an_instance_of List
    end

    it 'tells you its name' do
      list = List.new('Epicodus stuff', 1)
      list.list_name.should eq 'Epicodus stuff'
    end

    it 'is the same list if it has the same name' do
      list1 = List.new('Epicodus stuff', 1)
      list2 = List.new('Epicodus stuff', 1)
      list1.should eq list2
    end

    it 'starts off with no lists' do
      List.all.should eq []
    end

    it 'lets you save lists to the db' do
      list = List.new('Grocery Shopping', 1)
      list.save
      List.all.should eq [list]
    end

    it 'sets its ID when you save it' do
      list = List.new('Things to clean', 1)
      list.save
      list.id.should be_an_instance_of Fixnum
    end
  end

  describe 'return_tasks' do
    it 'returns an array of the tasks held within a list' do
      list = List.new('Things to clean', 1)
      list.save
      task = Task.new('the floor', list.id)
      task.save
      list.return_tasks('Things to clean').should eq ['the floor']
    end
  end
end
