# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/todo_lists/index.json.jbuilder', type: :view do
  let(:user) { create(:user) }
  let(:todo_list1) { create(:todo_list, title: '2025/07/18', author: user) }
  let(:todo_list2) { create(:todo_list, title: '2025/07/19', author: user) }

  let(:todo_list_item1) { create(:todo_list_item, author: user, todo_list: todo_list1) }
  let(:todo_list_item2) { create(:todo_list_item, author: user, todo_list: todo_list1) }

  before do
    todo_list_item1
    todo_list_item2
    assign(:todo_lists, [todo_list1, todo_list2])
    render
  end

  it '期待するレスポンスが返却される' do
    parsed_json = JSON.parse(rendered)
    expect(parsed_json).to eq([
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
                                      'id' => todo_list_item2.id,
                                      'content' => todo_list_item2.content,
                                      'status' => todo_list_item2.status
                                    },
                                    {
                                      'id' => todo_list_item1.id,
                                      'content' => todo_list_item1.content,
                                      'status' => todo_list_item1.status
                                    }
                                  ]
                                },
                                {
                                  'id' => todo_list2.id,
                                  'title' => todo_list2.title,
                                  'author' => {
                                    'id' => user.id,
                                    'name' => user.name
                                  },
                                  'is_current' => todo_list2.is_current,
                                  'todo_list_items' => []
                                }
                              ])
  end
end
