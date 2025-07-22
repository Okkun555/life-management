require 'rails_helper'

RSpec.describe "Api::TodoListItems", type: :request do
  describe "POST /api/todo_list/:todo_list_id/todo_list_item" do
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
  end

end
