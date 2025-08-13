# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::TodoLists', type: :request do
  let(:user) { create(:user) }

  before { login(user) }

  describe 'GET /api/todo_lists' do
    let(:other_user) { create(:user) }

    before do
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
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq([
                                             {
                                               'id' => todo_list2.id,
                                               'title' => todo_list2.title,
                                               'author' => {
                                                 'id' => user.id,
                                                 'name' => user.name
                                               },
                                               'is_current' => todo_list2.is_current,
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

  describe 'GET /api/todo_lists/:id' do
    let(:target_todo_list) { create(:todo_list, title: '2025/07/18', author: user) }
    let(:target_todo_list_item1) { create(:todo_list_item, content: 'やること1', author: user, todo_list: target_todo_list) }
    let(:target_todo_list_item2) { create(:todo_list_item, content: 'やること2', author: user, todo_list: target_todo_list) }

    let(:id) { target_todo_list.id }

    before do
      target_todo_list_item1
      target_todo_list_item2

      create(:todo_list_item, content: 'やること1', author: user, todo_list: create(:todo_list, title: '2025/07/19', author: user))

      subject
    end

    it '200ステータスが返却される' do
      expect(response).to have_http_status(:ok)
    end

    it 'TODOリストの詳細が返却される' do
      expect(response.parsed_body).to eq({
                                           'id' => target_todo_list.id,
                                           'title' => target_todo_list.title,
                                           'author' => {
                                             'id' => user.id,
                                             'name' => user.name
                                           },
                                           'is_current' => target_todo_list.is_current,
                                           'todo_list_items' => [
                                             {
                                               'id' => target_todo_list_item1.id,
                                               'content' => target_todo_list_item1.content,
                                               'status' => target_todo_list_item1.status
                                             },
                                             {
                                               'id' => target_todo_list_item2.id,
                                               'content' => target_todo_list_item2.content,
                                               'status' => target_todo_list_item2.status
                                             }
                                           ]
                                         })
    end
  end

  describe 'GET /api/todo_lists/latest' do
    let(:todo_list1) { create(:todo_list, title: '2025/07/18', author: user, created_at: Time.zone.parse('2025/07/18 00:00:00')) }
    let(:todo_list2) { create(:todo_list, title: '2025/07/19', author: user, created_at: Time.zone.parse('2025/07/19 00:00:00')) }

    context '正常系' do
      let(:current_todo_list) do
        create(:todo_list, title: '2025/07/20', author: user, created_at: Time.zone.parse('2025/07/20 00:00:00'), is_current: true)
      end
      let(:todo_list_item1) { create(:todo_list_item, content: 'やること1', author: user, todo_list: current_todo_list) }
      let(:todo_list_item2) { create(:todo_list_item, content: 'やること2', author: user, todo_list: current_todo_list) }

      before do
        todo_list_item1
        todo_list_item2

        create(:todo_list_item, content: 'やること3', author: user, todo_list: todo_list1)
        create(:todo_list_item, content: 'やること4', author: user, todo_list: todo_list2)

        subject
      end

      it '200ステータスが返却される' do
        expect(response).to have_http_status(:ok)
      end

      it '最新のTODOリストが返却される' do
        expect(response.parsed_body).to eq({
                                             'id' => current_todo_list.id,
                                             'title' => current_todo_list.title,
                                             'author' => {
                                               'id' => user.id,
                                               'name' => user.name
                                             },
                                             'is_current' => current_todo_list.is_current,
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
                                           })
      end
    end

    context '異常系' do
      context '本日対象のTODOリストが存在しない場合' do
        before { subject }

        it '500ステータスが返却される' do
          expect(response).to have_http_status(:internal_server_error)
          expect(response.parsed_body).to eq({ 'error' => '予期せぬエラーが発生しました。管理者にお問い合わせください。' })
        end
      end
    end
  end
end
