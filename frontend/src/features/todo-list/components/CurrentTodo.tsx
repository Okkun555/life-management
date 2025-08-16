"use client";

import { Typography } from "@mui/material";
import { Suspense } from "react";

import { useFetchCurrentTodoList } from "@/hooks/api/todo-list/useTodoApi";


export const CurrentTodo = () => {
  const { todoList } = useFetchCurrentTodoList();

  return (
    <Suspense fallback={<div>Loading...</div>}>
      <>
        <Typography variant="h6">{todoList?.title}のTODO管理</Typography>
      </>
    </Suspense>
  );
};