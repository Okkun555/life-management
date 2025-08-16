export type TodoList = {
  id: number;
  title: string;
  todoListItems: Array<TodoItem>
}

export type TodoItem = {
  id: number;
  content: string;
  status: "pending" | "completed";
  author: {
    id: number;
    name: string;
  }
}