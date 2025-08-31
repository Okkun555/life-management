import { TodoItem, TodoList } from "@/features/todo-list/types";

/**
 * TODOリストに登録されたTODOのステータス更新
 */
export type ChangeTodoItemStatusParams = Pick<TodoItem, "id" | "status">;
export type ChangeTodoItemStatusResponse = TodoItem & {
  todoList: Omit<TodoList, "todoListItems">;
};
