"use client";

import { useParams } from "next/navigation";

import { useFetchTodoList } from "@/hooks/api/todo-list/useTodoApi";

import { TargetTodoList } from "./TargetTodoList";

export const TargetTodoListAdapter = () => {
  const { id } = useParams<{ id: string }>();

  const { todoList, isLoading } = useFetchTodoList(Number(id));

  return <TargetTodoList todoList={todoList ?? undefined} isLoading={isLoading} />;
};
