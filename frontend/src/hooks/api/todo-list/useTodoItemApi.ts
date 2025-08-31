import { mutate } from "swr";
import useSWRMutation from "swr/mutation";

import { deleteRequest, postRequest } from "@/libs/api/fetcher";
import { path } from "@/libs/api/path";

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
