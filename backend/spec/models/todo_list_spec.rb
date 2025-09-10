require 'rails_helper'

RSpec.describe TodoList, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let!(:todo_list3) { create(:todo_list, title: '2024/07/18', author: other_user) }

  describe 'by_author' do
    context '本人のTODOリストが存在する場合' do
      let(:todo_list1) { create(:todo_list, title: '本人のTODOリスト1', author: user) }
      let(:todo_list2) { create(:todo_list, title: '本人のTODOリスト2', author: user) }

      before do
        todo_list1
        todo_list2
      end

      it '本人のTODOリストが返却される' do
        expect(TodoList.by_author(user)).to eq([todo_list1, todo_list2])
      end
    end

    context '本人のTODOリストが存在しない場合' do
      it '空の配列が返却される' do
        expect(TodoList.by_author(user)).to eq([])
      end
    end
  end

  describe 'ordered_by_date' do
    let(:todo_list1) { create(:todo_list, title: '2025/07/18', author: user) }
    let(:todo_list2) { create(:todo_list, title: '2025/07/19', author: user) }

    before do
      todo_list1
      todo_list2
    end

    it '日付順に並び替えられたTODOリストが返却される' do
      expect(TodoList.ordered_by_date).to eq([todo_list2, todo_list1, todo_list3])
    end
  end

  describe 'create_current_todo_list' do
    context '本日のTODOリストが存在しない場合' do
      it '本日のTODOリストが作成される' do
        expect { TodoList.create_current_todo_list(user) }.to change(TodoList, :count).by(1)
      end
    end

    context '本日のTODOリストが存在する場合' do
      let!(:todo_list) { create(:todo_list, title: Time.zone.today.strftime('%Y/%m/%d'), author: user) }

      it 'エラーが発生する' do
        expect { TodoList.create_current_todo_list(user) }.to raise_error(StandardError, '本日のTODOリストはすでに存在します')
      end
    end
  end

  describe 'completed_rate' do
    context 'TODOリストに紐づくTODOリストアイテムが存在しない場合' do
      let(:todo_list) { create(:todo_list, author: user) }

      it 'nilが返却される' do
        expect(todo_list.completed_rate).to be_nil
      end
    end

    context 'TODOリストに紐づくTODOリストアイテムが存在する場合' do
      context '全てのTODOリストアイテムが完了している場合' do
        let!(:todo_list) { create(:todo_list, author: user) }
        let!(:todo_list_item1) { create(:todo_list_item, todo_list: todo_list, status: :completed) }
        let!(:todo_list_item2) { create(:todo_list_item, todo_list: todo_list, status: :completed) }

        it '100が返却される' do
          expect(todo_list.completed_rate).to eq(100)
        end
      end

      context '全てのTODOリストアイテムが未完了の場合' do
        let!(:todo_list) { create(:todo_list, author: user) }
        let!(:todo_list_item1) { create(:todo_list_item, todo_list: todo_list, status: :pending) }
        let!(:todo_list_item2) { create(:todo_list_item, todo_list: todo_list, status: :pending) }

        it '0が返却される' do
          expect(todo_list.completed_rate).to eq(0)
        end
      end

      context 'TODOリストアイテムが1/3完了している場合' do
        let!(:todo_list) { create(:todo_list, author: user) }
        let!(:todo_list_item1) { create(:todo_list_item, todo_list: todo_list, status: :completed) }
        let!(:todo_list_item2) { create(:todo_list_item, todo_list: todo_list, status: :pending) }
        let!(:todo_list_item3) { create(:todo_list_item, todo_list: todo_list, status: :pending) }

        it '66.67が返却される' do
          expect(todo_list.completed_rate).to eq(33)
        end
      end
    end
  end
end
