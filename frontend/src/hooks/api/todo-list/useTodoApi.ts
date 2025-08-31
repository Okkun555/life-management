import useSWR from "swr";

import { TodoList } from "@/features/todo-list/types";
import { fetcher } from "@/libs/api/fetcher";
import { path } from "@/libs/api/path";

export const useFetchCurrentTodoList = () => {
  const { data, isLoading } = useSWR<TodoList>(path.currentTodoList, fetcher);

  return {
    todoList: data,
    isLoading,
  };
};
