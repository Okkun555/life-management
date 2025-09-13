import Link from "next/link";

import { Box, Button, CircularProgress, Typography } from "@/components/mui";

import { TodoItemList } from "../TodoItemList";

import type { TodoList } from "@/features/todo-list/types";

type TargetTodoListProps = {
  todoList: TodoList | undefined;
  isLoading: boolean;
};

export const TargetTodoList = ({ todoList, isLoading }: TargetTodoListProps) => {
  if (isLoading) {
    return <CircularProgress />;
  }

  return (
    <>
      <Box display="flex" justifyContent="space-between" alignItems="center">
        <Typography variant="h5" component="h2">
          {todoList?.title}のTODO管理
        </Typography>
        <Button sx={{ mr: 2 }}>
          <Link href={"/todo-list"}>本日のTODOを表示する</Link>
        </Button>
      </Box>
      <Box sx={{ mt: 3 }}>{todoList?.todoListItems && <TodoItemList todoList={todoList} />}</Box>
    </>
  );
};
