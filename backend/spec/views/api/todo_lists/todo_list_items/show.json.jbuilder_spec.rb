# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/todo_lists/todo_list_items/show.json.jbuilder', type: :view do
  let(:user) { create(:user) }
  let(:todo_list) { create(:todo_list, author: user) }
  let(:todo_list_item) { create(:todo_list_item, author: user, todo_list: todo_list) }

  before do
    assign(:todo_list_item, todo_list_item)
    render
  end

  describe 'レンダリング結果' do
    it '期待するレスポンスが返却される' do
      parsed_json = JSON.parse(rendered)
      expect(parsed_json).to eq({
                                  'id' => todo_list_item.id,
                                  'content' => todo_list_item.content,
                                  'status' => todo_list_item.status,
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
end
