export type TodoList = {
  id: number;
  title: string;
  todoListItems: Array<TodoItem>;
};

export type TodoItem = {
  id: number;
  content: string;
  status: "pending" | "completed";
  // FIXME: TODOアイテムの作成者が毎回くるのは気持ち悪いかも...TODO List側で一度渡せばOKでは？
  author: {
    id: number;
    name: string;
  };
};

// TodoItem作成時に必要なデータ
export type CreateTodoItemRequest = {
  content: string;
};
