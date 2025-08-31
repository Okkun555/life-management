export type TodoList = {
  id: number;
  title: string;
  todoListItems: Array<TodoItem>;
  author: {
    id: number;
    name: string;
  };
};

export type TodoItem = {
  id: number;
  content: string;
  status: "pending" | "completed";
};

// TodoItem作成時に必要なデータ
export type CreateTodoItemRequest = {
  content: string;
};
