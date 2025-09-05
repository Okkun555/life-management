"use client";

import { CircularProgress, Typography } from "@/components/mui";

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
    </>
  );
};
