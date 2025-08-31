import { mutate } from "swr";
import useSWRMutation from "swr/mutation";

import { deleteRequest, postRequest, putRequest } from "@/libs/api/fetcher";
import { path } from "@/libs/api/path";

import type { ChangeTodoItemStatusParams, ChangeTodoItemStatusResponse } from "./type";
import type { TodoItem, TodoList } from "@/features/todo-list/types";

/**
 * TODOリストにTODOを追加する
 * @param id
 * @returns
 */
export const useAddTodoItem = (id: TodoList["id"]) => {
  const { trigger, isMutating } = useSWRMutation(path.addTodoItem(id), postRequest, {
    onSuccess: () => {
      mutate(path.currentTodoList);
    },
  });

  return { trigger, isMutating };
};

/**
 * TODOリストに登録されたTODOを削除する
 * @param todoListId
 * @returns
 */
export const useDeleteTodoItem = (todoListId: TodoList["id"]) => {
  const { trigger, isMutating } = useSWRMutation(
    `delete_todo_item_${todoListId}`,
    async (_key: string, { arg }: { arg: { todoItemId: TodoItem["id"] } }) => {
      return deleteRequest(path.deleteTodoItem(todoListId, arg.todoItemId));
    },
    {
      onSuccess: () => {
        mutate(path.currentTodoList);
      },
    },
  );

  return { trigger, isMutating };
};

/**
 * TODOリストに登録されたTODOのステータスを更新する
 * @param todoListId
 * @returns
 */
export const useChangeTodoItemStatus = (todoListId: TodoList["id"]) => {
  const { trigger, isMutating } = useSWRMutation(
    `update_todo_item_status_${todoListId}`,
    async (_key: string, { arg }: { arg: ChangeTodoItemStatusParams }) => {
      return putRequest<Pick<TodoItem, "status">, ChangeTodoItemStatusResponse>(
        path.updateTodoItemStatus(todoListId, arg.id),
        {
          arg: {
            status: arg.status,
          },
        },
      );
    },
    {
      onSuccess: () => {
        mutate(path.currentTodoList);
      },
    },
  );

  return { trigger, isMutating };
};
