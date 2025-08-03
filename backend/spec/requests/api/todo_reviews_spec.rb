# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::TodoList::TodoReviews', type: :request do
  describe 'POST /api/todo_lists/:todo_list_id/todo_review' do
    context 'ログイン済みの場合' do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_id) { todo_list.id }

      before { login(user) }

      context '正常なリクエストの場合' do
        let(:params) { { todo_review: { review: 'test' } } }
        it '作成したTODOレビューとステータスコード201を返す' do
          subject

          created_todo_review = TodoReview.last
          expect(response).to have_http_status(:created)
          expect(response.parsed_body).to eq({
                                               'id' => created_todo_review.id,
                                               'review' => 'test',
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
        context 'レビューが空の場合' do
          let(:params) { { todo_review: { review: '' } } }
          it 'ステータスコード422を返す' do
            subject
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end

    context '未ログインの場合' do
      let(:todo_list) { create(:todo_list) }
      let(:todo_list_id) { todo_list.id }
      let(:headers) do
        {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        }
      end

      context '正常なリクエストの場合' do
        let(:params) { { todo_review: { review: 'test' } } }
        it 'ステータスコード401を返す' do
          subject
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  describe 'PUT /api/todo_lists/:todo_list_id/todo_review' do
    let(:user) { create(:user) }
    let(:todo_list) { create(:todo_list, author: user) }
    let(:todo_list_id) { todo_list.id }
    let(:todo_review) { create(:todo_review, todo_list: todo_list, author: user) }
    let(:headers) do
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'X-Dev-User-UID' => user.supabase_uid
      }
    end

    before do
      todo_review
    end

    context '正常なリクエストの場合' do
      let(:params) { { todo_review: { review: 'test' } } }
      it '更新したTODOレビューとステータスコード200を返す' do
        subject

        updated_todo_review = TodoReview.last
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq({
                                             'id' => updated_todo_review.id,
                                             'review' => 'test',
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
      context 'レビューが空の場合' do
        let(:params) { { todo_review: { review: '' } } }
        it 'ステータスコード422を返す' do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'レビュー作成したユーザーと異なるユーザーがリクエストした場合' do
        let(:params) { { todo_review: { review: 'test' } } }
        let(:other_user) { create(:user) }
        let(:other_user_todo_list) { create(:todo_list, author: other_user) }
        let(:headers) do
          {
            'Accept' => 'application/json',
            'Content-Type' => 'application/json',
            'X-Dev-User-UID' => other_user.supabase_uid
          }
        end

        before do
          other_user_todo_list
        end

        it 'ステータスコード404を返す' do
          subject
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
