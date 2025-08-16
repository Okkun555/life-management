import useSWR from "swr";

import { TodoList } from "@/features/todo-list/types";
import { fetcher } from "@/libs/api/fetcher";
import { path } from "@/libs/api/path";

export const useFetchCurrentTodoList = () => {
  const { data, isLoading } = useSWR<TodoList>(
    path.currentTodoList, 
    fetcher,
    {
      fallbackData: undefined, // 明示的にfallbackDataを設定
      suspense: false // または、個別にsuspenseを無効化
    }
  );

  return { 
    todoList: data,
    isLoading
  };
};