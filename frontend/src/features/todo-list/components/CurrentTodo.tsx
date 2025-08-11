"use client";

import { Typography } from "@mui/material";

import { useFetchTodoList } from "@/hooks/api/todo-list/useTodoApi";


export const CurrentTodo = () => {
  const { data } = useFetchTodoList(1);

  console.log(data);

  return (
    <>
      <Typography variant="h6">Current Todo</Typography>
    </>
  );
};