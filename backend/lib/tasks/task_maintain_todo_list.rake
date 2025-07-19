namespace :task_maintain_todo_list do
  desc '実行日のTODOリストを作成し、前日のTODOリストのis_currentをfalseにする'
  task maintain_todo_list: :environment do
    User.reset_previous_current_todo_lists
    User.create_daily_todo_lists
  end
end
