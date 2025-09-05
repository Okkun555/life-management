export const path = {
  // TODOリスト
  currentTodoList: "/todo_lists/latest",
  allTodoList: "/todo_lists",
  todoList: (todoListId: number) => `/todo_lists/${todoListId}`,
  addTodoItem: (todoListId: number) => `/todo_lists/${todoListId}/todo_list_items`,
  deleteTodoItem: (todoListId: number, todoItemId: number) =>
    `/todo_lists/${todoListId}/todo_list_items/${todoItemId}`,
  updateTodoItemStatus: (todoListId: number, todoItemId: number) =>
    `/todo_lists/${todoListId}/todo_list_items/${todoItemId}/status`,
};
