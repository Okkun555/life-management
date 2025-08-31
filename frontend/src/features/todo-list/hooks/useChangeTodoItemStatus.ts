import { useCallback } from "react";

import { TodoList } from "@/features/todo-list/types";
import { useChangeTodoItemStatus as useChangeTodoItemStatusApi } from "@/hooks/api/todo-list/useTodoItemApi";

import type { ChangeTodoItemStatusParams } from "@/hooks/api/todo-list/type";

export const useChangeTodoItemStatus = (todoListId: TodoList["id"]) => {
  const { trigger } = useChangeTodoItemStatusApi(todoListId);

  const handleChangeTodoItemStatus = useCallback(
    async (arg: ChangeTodoItemStatusParams) => await trigger(arg),
    [trigger],
  );

  return { handleChangeTodoItemStatus };
};
