"use client";

import { Typography, CircularProgress, Box } from "@/components/mui";
import { AddTodoForm } from "@/features/todo-list/components/presenters/AddTodoForm";
import { TodoItemList } from "@/features/todo-list/components/presenters/TodoItemList";
import {
  ChangeTodoItemStatusParams,
  ChangeTodoItemStatusResponse,
} from "@/hooks/api/todo-list/type";

import type { TodoItem, TodoList } from "@/features/todo-list/types";

type CurrentTodoListProps = {
  isLoading: boolean;
  todoList: TodoList | undefined;
  handleDeleteTodoItem: (_todoItemId: TodoItem["id"]) => void;
  handleChangeTodoItemStatus: (
    _arg: ChangeTodoItemStatusParams,
  ) => Promise<ChangeTodoItemStatusResponse>;
};

export const CurrentTodoList = ({
  isLoading,
  todoList,
  handleDeleteTodoItem,
  handleChangeTodoItemStatus,
}: CurrentTodoListProps) => {
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
        {todoList.todoListItems && (
          <TodoItemList
            todoItems={todoList.todoListItems}
            handleDeleteTodoItem={handleDeleteTodoItem}
            handleChangeTodoItemStatus={handleChangeTodoItemStatus}
          />
        )}
      </Box>
    </>
  );
};
