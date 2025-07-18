require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.create_daily_todo_lists' do
    let(:today) { Date.current.strftime('%Y-%m-%d') }

    context 'ユーザーが存在しない場合' do
      it 'TodoListを作成しない' do
        expect { User.create_daily_todo_lists }.not_to change(TodoList, :count)
      end
    end

    context 'ユーザーが存在する場合' do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }

      it '各ユーザーに当日の日付でTodoListを作成する' do
        expect { User.create_daily_todo_lists }.to change(TodoList, :count).by(2)
        
        expect(user1.todo_lists.find_by(title: today)).to be_present
        expect(user2.todo_lists.find_by(title: today)).to be_present
      end

      it '作成されるTodoListのis_currentがtrueになる' do
        User.create_daily_todo_lists
        
        expect(user1.todo_lists.find_by(title: today).is_current).to be true
        expect(user2.todo_lists.find_by(title: today).is_current).to be true
      end

      it 'タイトルが正しい日付フォーマット（YYYY-MM-DD）になる' do
        User.create_daily_todo_lists
        
        expect(user1.todo_lists.find_by(title: today).title).to eq today
        expect(user2.todo_lists.find_by(title: today).title).to eq today
      end
    end

    context '既に当日のTodoListが存在する場合' do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:existing_todo_list) { create(:todo_list, author: user1, title: today) }

      it '既存のユーザーには作成せず、新しいユーザーのみ作成する' do
        expect { User.create_daily_todo_lists }.to change(TodoList, :count).by(1)
        
        # user1は既存のTodoListのまま
        expect(user1.todo_lists.where(title: today).count).to eq 1
        expect(user1.todo_lists.find_by(title: today)).to eq existing_todo_list
        
        # user2には新しく作成される
        expect(user2.todo_lists.find_by(title: today)).to be_present
      end
    end
  end
end
