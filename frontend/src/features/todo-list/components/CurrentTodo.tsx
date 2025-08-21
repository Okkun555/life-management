"use client";

import { useForm } from "react-hook-form";

import { TextFieldController } from "@/components/forms/text-field";
import { Typography, CircularProgress } from "@/components/mui";
import { useFetchCurrentTodoList } from "@/hooks/api/todo-list/useTodoApi";


export const CurrentTodo = () => {
  const { todoList, isLoading } = useFetchCurrentTodoList();

  const { register } = useForm({
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
      <TextFieldController<{content: string}> registration={register("content")} textField={{ fieldWrapper: { label: "TODO" }  }} />
    </>
  
  );
};