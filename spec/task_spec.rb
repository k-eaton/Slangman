require 'spec_helper'

describe Tasks do

  before(:all) do
    Task.delete_all

    @task = Task.new
    @task.assign_attributes(
      :list_id => 1,
      :text => "testing, 1, 2, 3",
      :is_completed => false
      )
  end

  it "has list_id, text, and is_completed methods" do
    [:list_id, :text, :is_completed].each { |mthd| expect(@task).to respond_to mthd }
  end

end
