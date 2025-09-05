"use client";

import { Box, CircularProgress, Grid, Typography } from "@/components/mui";

import { TodoListCard } from "../TodoListCard";

import type { TodoList } from "@/features/todo-list/types";

type AllTodoListProps = {
  todoLists: TodoList[];
  isLoading: boolean;
};

export const AllTodoList = ({ todoLists, isLoading }: AllTodoListProps) => {
  if (isLoading) {
    return <CircularProgress />;
  }

  // TODO: useEffect等でTODOリストがない場合はcreateを叩くようにしてもいいかも
  if (!todoLists) {
    return (
      <Typography>
        TODOリストはありません。作成ボタンを押下して今日のTODOを作成しましょう
      </Typography>
    );
  }

  return (
    <>
      <Typography variant="h5" component="h2">
        TODOリスト一覧
      </Typography>
      <Box sx={{ mt: 3 }}>
        <Grid container spacing={2}>
          {todoLists.map((list) => (
            <Grid key={list.id} size={{ xs: 12, sm: 6, md: 3 }}>
              <TodoListCard todoList={list} />
            </Grid>
          ))}
        </Grid>
      </Box>
    </>
  );
};
