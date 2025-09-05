import useSWR from "swr";

import { TodoList } from "@/features/todo-list/types";
import { fetcher } from "@/libs/api/fetcher";
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
