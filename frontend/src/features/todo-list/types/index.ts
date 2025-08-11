export type TodoList = {
  id: number;
  title: string;
}

export type TodoItem = {
  id: number;
  content: string;
  status: "pending" | "completed";
  author: {
    id: number;
    name: string;
  },
  todoList: TodoList;
}