import { useCallback } from "react";

import { useDeleteTodoItem as useDeleteTodoItemApi } from "@/hooks/api/todo-list/useTodoItemApi";

import type { TodoItem, TodoList } from "@/features/todo-list/types";

export const useDeleteTodoItem = (todoListId: TodoList["id"]) => {
  const { trigger } = useDeleteTodoItemApi(todoListId);

  const handleDeleteTodoItem = useCallback(
    async (todoItemId: TodoItem["id"]) => await trigger({ todoItemId }),
    [trigger],
  );

  return { handleDeleteTodoItem };
};
