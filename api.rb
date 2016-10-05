require 'sinatra'
require 'active_record'
require_relative 'environment'
require_relative 'tasks'

after do
  ActiveRecord::Base.connection.close
end
#list all and/or sort by a certain thing
#/api/tasks?order=description
get '/api/tasks' do
  order = params[:order] || 'id'

  Tasks.order(order).to_json
end
#get by certain thing
# #localhost4567/api/tasks?id=1&selection="ASC"
get '/api/tasks/select' do
  selection = params[:selection] || 'id'

  Tasks.select(selection).to_json
end

#find task by id
get '/api/tasks/:id' do
  task = Tasks.where(id: params[:id])
  task.to_json
end
#update
post '/api/tasks/:id/update/:description' do
  task = Tasks.where(id: params[:id]).first
  task.update(description: params[:description])
  task.to_json
end
#make a task
post '/api/tasks' do
  description = params[:description]
  task = Tasks.create(description: description)
  task.to_json
end
#make a task completed
post '/api/tasks/status/:id' do
  status = Tasks.where(id: params[:id]).first
  status.completed = True
end
#to delete by id
post '/api/tasks/:id' do
  task = Tasks.where(id: params[:id]).first
  task.to_json
  task.delete
end
