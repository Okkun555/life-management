"use client";

import { Typography, CircularProgress, Box } from "@/components/mui";

import { AddTodoForm } from "../presenters/AddTodoForm";
import { TodoItemList } from "../presenters/TodoItemList";

import type { TodoList } from "@/features/todo-list/types";

type CurrentTodoListProps = {
  isLoading: boolean;
  todoList: TodoList | undefined;
};

export const CurrentTodoList = ({ isLoading, todoList }: CurrentTodoListProps) => {
  if (isLoading) {
    return <CircularProgress />;
  }

  if (!todoList) {
    return (
      <Typography color="error">
        予期せぬエラーが発生しています。管理者にお問い合わせください。（エラーコード：1001）
      </Typography>
    );
  }

  return (
    <>
      <Typography variant="h5" component="h2">
        {todoList.title}のTODO管理
      </Typography>
      <AddTodoForm todoListId={todoList.id} />
      <Box sx={{ mt: 3 }}>
        {todoList.todoListItems && <TodoItemList todoItems={todoList.todoListItems} />}
      </Box>
    </>
  );
};
