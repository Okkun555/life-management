# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::TodoLists', type: :request do
  describe 'GET /api/todo_lists' do
    let(:other_user) { create(:user) }
    let(:user) { create(:user) }

    before do
      login(user)

      create(:todo_list, title: '他人のTODOリスト1', author: other_user)
      create(:todo_list_item, content: '他人のやること1', author: other_user)
    end

    context '本人のTODOリストが存在しない場合' do
      before { subject }

      it '空の配列と200ステータスが返却される' do
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq([])
      end
    end

    context '本人のTODOリストが存在する場合' do
      let(:todo_list1) do
        create(:todo_list, title: '2025/07/18', author: user, created_at: Time.zone.parse('2025/07/18 00:00:00'))
      end
      let(:todo_list2) do
        create(:todo_list, title: '2025/07/19', author: user, created_at: Time.zone.parse('2025/07/19 00:00:00'))
      end
      let(:todo_list_item1) { create(:todo_list_item, content: 'やること1', author: user, todo_list: todo_list1) }
      let(:todo_list_item2) { create(:todo_list_item, content: 'やること2', author: user, todo_list: todo_list1) }

      before do
        todo_list1
        todo_list2
        todo_list_item1
        todo_list_item2
      end

      it '本人のTODOリストと200ステータスが返却される' do
        subject
        expect(response.parsed_body).to eq([
                                             {
                                               'id' => todo_list2.id,
                                               'title' => todo_list2.title,
                                               'author' => {
                                                 'id' => user.id,
                                                 'name' => user.name
                                               },
                                               'is_current' => todo_list2.is_current,
                                               'created_at' => todo_list2.created_at.strftime('%Y/%m/%d %H:%M:%S'),
                                               'todo_list_items' => []
                                             },
                                             {
                                               'id' => todo_list1.id,
                                               'title' => todo_list1.title,
                                               'author' => {
                                                 'id' => user.id,
                                                 'name' => user.name
                                               },
                                               'is_current' => todo_list1.is_current,
                                               'created_at' => todo_list1.created_at.strftime('%Y/%m/%d %H:%M:%S'),
                                               'todo_list_items' => [
                                                 {
                                                   'id' => todo_list_item1.id,
                                                   'content' => todo_list_item1.content,
                                                   'status' => todo_list_item1.status
                                                 },
                                                 {
                                                   'id' => todo_list_item2.id,
                                                   'content' => todo_list_item2.content,
                                                   'status' => todo_list_item2.status
                                                 }
                                               ]
                                             }
                                           ])
      end
    end
  end
end
