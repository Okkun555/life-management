require 'rails_helper'

RSpec.describe "Api::TodoListItems", type: :request do
  describe "POST /api/todo_lists/:todo_list_id/todo_list_items" do
    context "ログイン済みの場合" do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_id) { todo_list.id }
      let(:headers) do
        {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json',
          'X-Dev-User-UID' => user.supabase_uid
        }
      end

      context "正常なリクエストの場合" do
        let(:params) { { todo_list_item: { content: 'test' } } }
        it "作成したTODOリストアイテムとステータスコード201を返す" do
          subject
  
          expect(response).to have_http_status(:created)
  
          response_json = JSON.parse(response.body)
          created_todo_list_item = TodoListItem.last
  
          expect(response_json).to eq({
            'id' => created_todo_list_item.id,
            'content' => 'test',
            'status' => 'pending',
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

      context "異常なリクエストの場合" do
        context "contentが空の場合" do
          let(:params) { { todo_list_item: { content: '' } } }
          it "エラーメッセージとステータスコード422を返す" do
            subject
            expect(response).to have_http_status(:unprocessable_entity)

            response_json = JSON.parse(response.body)
            expect(response_json).to eq({
              'errors' => ['TODOを入力してください']
            })
          end
        end
      end
    end

    context "未ログインの場合" do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_id) { todo_list.id }
      let(:params) { { todo_list_item: { content: 'test' } } }

      it "ステータスコード401を返す" do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "PUT /api/todo_lists/:todo_list_id/todo_list_items/:todo_list_item_id" do
    context "ログイン済みの場合" do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_item) { create(:todo_list_item, author: user, todo_list: todo_list) }
      let(:todo_list_id) { todo_list.id }
      let(:todo_list_item_id) { todo_list_item.id }
      let(:headers) do
        {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json',
          'X-Dev-User-UID' => user.supabase_uid
        }
      end

      context "正常なリクエストの場合" do
        let(:params) { { todo_list_item: { content: 'update content' } } }

        it "更新したTODOリストアイテムとステータスコード200を返す" do
          subject
          expect(response).to have_http_status(:ok)

          response_json = JSON.parse(response.body)
          expect(response_json).to eq({
            'id' => todo_list_item.id,
            'content' => 'update content',
            'status' => 'pending',
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

      context "異常なリクエストの場合" do
        context "contentが空の場合" do
          let(:params) { { todo_list_item: { content: '' } } }

          it "エラーメッセージとステータスコード422を返す" do
            subject
            expect(response).to have_http_status(:unprocessable_entity)

            response_json = JSON.parse(response.body)
            expect(response_json).to eq({
              'errors' => ['TODOを入力してください']
            })  
          end
        end
      end
    end

    context "未ログインの場合" do
      let(:user) { create(:user) }
      let(:todo_list) { create(:todo_list, author: user) }
      let(:todo_list_id) { todo_list.id }
      let(:todo_list_item) { create(:todo_list_item, todo_list: todo_list) }
      let(:todo_list_item_id) { todo_list_item.id }
      let(:params) { { todo_list_item: { content: 'update content' } } }

      it "ステータスコード401を返す" do 
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
