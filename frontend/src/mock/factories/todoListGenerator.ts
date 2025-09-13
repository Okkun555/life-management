import { TodoList } from "@/features/todo-list/types";

import { generateTodoItems } from "./todoItemsGenerator";

export const generateTodoList = (): TodoList => ({
  id: 1,
  title: "Todo List 1",
  todoListItems: generateTodoItems(2),
  completedRate: 50,
  author: {
    id: 1,
    name: "Author 1",
  },
});

export const generateEmptyTodoList = (): TodoList => ({
  id: 1,
  title: "Todo List 1",
  todoListItems: [],
  completedRate: 0,
  author: {
    id: 1,
    name: "Author 1",
  },
});
