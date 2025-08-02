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
end
