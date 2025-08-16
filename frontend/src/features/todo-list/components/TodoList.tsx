"use client";



import { Box } from "@/components/mui";

import { CurrentTodo } from "./CurrentTodo";
import { TodoListTab } from "./TodoListTab";

export const TodoList = () => {
  return (
    <>
      <TodoListTab />
      <Box sx={{ mt: 2 }}>
        <CurrentTodo />
      </Box>
    </>
  );
};