import useSWR, { mutate } from "swr";
import useSWRMutation from "swr/mutation";

import { TodoList } from "@/features/todo-list/types";
import { fetcher, postRequest } from "@/libs/api/fetcher";
import { path } from "@/libs/api/path";

/**
 * すべてのTODOリストを取得
 * @returns
 */
export const useFetchAllTodoList = () => {
  const { data, isLoading } = useSWR<TodoList[]>(path.allTodoList, fetcher);

  return {
    todoLists: data,
    isLoading,
  };
};

/**
 * 本日のTODOリストを取得
 * @returns
 */
export const useFetchCurrentTodoList = () => {
  const { data, isLoading } = useSWR<TodoList>(path.currentTodoList, fetcher);

  return {
    todoList: data,
    isLoading,
  };
};

/**
 * 指定したIDのTODOリストを取得
 * @param id
 * @returns
 */
export const useFetchTodoList = (id: TodoList["id"]) => {
  const { data, isLoading } = useSWR<TodoList>(path.todoList(id), fetcher);

  return {
    todoList: data,
    isLoading,
  };
};

/**
 * 本日のTODOリストを作成（紐づくTODOリストが存在しない場合 = 初回アクセス時のみ）
 * @returns
 */
export const useAddTodoList = () => {
  const { trigger, isMutating } = useSWRMutation(path.addTodoList, postRequest, {
    onSuccess: () => {
      mutate(path.currentTodoList);
    },
  });

  return { trigger, isMutating };
};
