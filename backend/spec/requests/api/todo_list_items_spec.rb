# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::TodoListItems', type: :request do
  describe 'POST /api/todo_lists/:todo_list_id/todo_list_items' do
    context 'ログイン済みの場合' do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_id) { todo_list.id }

      before { login(user) }

      context '正常なリクエストの場合' do
        let(:params) { { todo_list_item: { content: 'test' } } }
        it '作成したTODOリストアイテムとステータスコード201を返す' do
          subject

          created_todo_list_item = TodoListItem.last
          expect(response).to have_http_status(:created)
          expect(response.parsed_body).to eq({
                                               'id' => created_todo_list_item.id,
                                               'content' => 'test',
                                               'status' => 'pending',
                                               'todo_list' => {
                                                 'id' => todo_list.id,
                                                 'title' => todo_list.title,
                                                 'author' => {
                                                   'id' => user.id,
                                                   'name' => user.name
                                                 }
                                               }
                                             })
        end
      end

      context '異常なリクエストの場合' do
        context 'contentが空の場合' do
          let(:params) { { todo_list_item: { content: '' } } }
          it 'エラーメッセージとステータスコード422を返す' do
            subject
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.parsed_body).to eq({
                                                 'errors' => ['TODOを入力してください']
                                               })
          end
        end
      end
    end

    context '未ログインの場合' do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_id) { todo_list.id }
      let(:params) { { todo_list_item: { content: 'test' } } }

      it 'ステータスコード401を返す' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /api/todo_lists/:todo_list_id/todo_list_items/:todo_list_item_id' do
    context 'ログイン済みの場合' do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_item) { create(:todo_list_item, author: user, todo_list: todo_list) }
      let(:todo_list_id) { todo_list.id }
      let(:todo_list_item_id) { todo_list_item.id }

      before { login(user) }

      context '正常なリクエストの場合' do
        let(:params) { { todo_list_item: { content: 'update content' } } }

        it '更新したTODOリストアイテムとステータスコード200を返す' do
          subject
          expect(response).to have_http_status(:ok)

          expect(response.parsed_body).to eq({
                                               'id' => todo_list_item.id,
                                               'content' => 'update content',
                                               'status' => 'pending',
                                               'todo_list' => {
                                                 'id' => todo_list.id,
                                                 'title' => todo_list.title,
                                                 'author' => {
                                                   'id' => user.id,
                                                   'name' => user.name
                                                 }
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

        context 'contentが空の場合' do
          let(:params) { { todo_list_item: { content: '' } } }

          it 'エラーメッセージとステータスコード422を返す' do
            subject
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.parsed_body).to eq({
                                                 'errors' => ['TODOを入力してください']
                                               })
          end
        end
      end
    end

    context '未ログインの場合' do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_id) { todo_list.id }
      let(:todo_list_item) { create(:todo_list_item, todo_list: todo_list) }
      let(:todo_list_item_id) { todo_list_item.id }
      let(:params) { { todo_list_item: { content: 'update content' } } }

      it 'ステータスコード401を返す' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/todo_lists/:todo_list_id/todo_list_items/:todo_list_item_id' do
    context 'ログイン済みの場合' do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_item) { create(:todo_list_item, author: user, todo_list: todo_list) }
      let(:todo_list_id) { todo_list.id }
      let(:todo_list_item_id) { todo_list_item.id }

      before do
        login(user)
        todo_list_item
      end

      context '正常なリクエストの場合' do
        it 'ステータスコード204を返す' do
          subject
          expect(response).to have_http_status(:no_content)
        end

        it 'TODOリストアイテムが削除される' do
          expect { subject }.to change(TodoListItem, :count).by(-1)
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
      end
    end

    context '未ログインの場合' do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_id) { todo_list.id }
    end
  end
end
