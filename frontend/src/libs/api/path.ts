export const path = {
  // TODOリスト
  currentTodoList: "/todo_lists/latest",
  addTodoItem: (todoListId: number) => `/todo_lists/${todoListId}/todo_list_items`,
  deleteTodoItem: (todoListId: number, todoItemId: number) =>
    `/todo_lists/${todoListId}/todo_list_items/${todoItemId}`,
};
