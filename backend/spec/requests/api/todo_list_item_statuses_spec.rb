# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::TodoListItemStatuses', type: :request do
  describe 'PATCH /api/todo_lists/:todo_list_id/todo_list_items/:todo_list_item_id/status' do
    context 'ログイン済みの場合' do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_item) { create(:todo_list_item, author: user, todo_list: todo_list, status: :pending) }
      let(:todo_list_id) { todo_list.id }
      let(:todo_list_item_id) { todo_list_item.id }
      let(:headers) do
        {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json',
          'X-Dev-User-UID' => user.supabase_uid
        }
      end

      context '正常なリクエストの場合' do
        let(:params) { { status: 'completed' } }
        it 'ステータスコード200を返す' do
          subject
          expect(response).to have_http_status(:ok)
          expect(response.parsed_body).to eq({
                                               'id' => todo_list_item.id,
                                               'content' => todo_list_item.content,
                                               'status' => 'completed',
                                               'author' => {
                                                 'id' => user.id,
                                                 'name' => user.name
                                               },
                                               'todo_list' => {
                                                 'id' => todo_list.id,
                                                 'title' => todo_list.title
                                               }
                                             })
        end
      end

      context '異常なリクエストの場合' do
        context '存在しないTODOリストアイテムの場合' do
          let(:todo_list_item_id) { 0 }
          it 'ステータスコード404を返す' do
            subject
            expect(response).to have_http_status(:not_found)
          end
        end

        context 'ステータスが不正な値の場合' do
          let(:params) { { status: 'invalid' } }
          it 'ステータスコード422を返す' do
            subject
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end

    context '未ログインの場合' do
      let(:todo_list) { create(:todo_list) }
      let(:todo_list_item) { create(:todo_list_item, todo_list: todo_list) }
      let(:todo_list_id) { todo_list.id }
      let(:todo_list_item_id) { todo_list_item.id }
      let(:headers) do
        {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        }
      end

      context '正常なリクエストの場合' do
        let(:params) { { status: 'completed' } }
        it 'ステータスコード401を返す' do
          subject
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
