"use client";

import { Typography, CircularProgress } from "@/components/mui";
import { useFetchCurrentTodoList } from "@/hooks/api/todo-list/useTodoApi";


export const CurrentTodo = () => {
  const { todoList, isLoading } = useFetchCurrentTodoList();

  if (isLoading) {
    return <CircularProgress />;
  }

  return (
    <>
      <Typography variant="h5" component="h2">{todoList?.title}のTODO管理</Typography>
    </>
  
  );
};