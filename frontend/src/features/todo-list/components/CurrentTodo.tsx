"use client";

import { useForm } from "react-hook-form";

import { TextField } from "@/components/forms/text-field/TextField";
import { Typography, CircularProgress } from "@/components/mui";
import { useFetchCurrentTodoList } from "@/hooks/api/todo-list/useTodoApi";


export const CurrentTodo = () => {
  const { todoList, isLoading } = useFetchCurrentTodoList();

  const { control } = useForm({
    defaultValues: {
      content: ""
    }
  });

  if (isLoading) {
    return <CircularProgress />;
  }

  return (
    <>
      <Typography variant="h5" component="h2">{todoList?.title}のTODO管理</Typography>
      
      <TextField<{content: string}> label="TODO" name="content" control={control} />
    </>
  
  );
};