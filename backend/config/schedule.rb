set :output, "log/cron.log"

set :environment, :production

every 1.day, at: '12:00 am' do
  rake "task_maintain_todo_list:maintain_todo_list"
end