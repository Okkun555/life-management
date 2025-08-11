"use client";

import useSWR from "swr";

import { TodoList } from "@/features/todo-list/types";
import { fetcher } from "@/libs/fetcher";

export const useFetchTodoList = (id: number) => {
  const { data } = useSWR<TodoList>(`/todo_lists/${id}`, fetcher);

  return { data };
};