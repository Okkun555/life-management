import { useCallback } from "react";
import { useForm } from "react-hook-form";

import { useAddTodoItem } from "@/hooks/api/todo-list/useTodoItemApi";

export type AddTodoFormValues = {
  content: string;
};

export const useAddTodoForm = (todoListId: number) => {
  const { register, handleSubmit } = useForm<AddTodoFormValues>({
    defaultValues: {
      content: "",
    },
  });

  const { trigger } = useAddTodoItem(todoListId);
  // TODO: 楽観的更新処理を入れてみる？
  const onSubmit = useCallback(async (data: AddTodoFormValues) => await trigger(data), [trigger]);

  return {
    register,
    handleSubmit,
    onSubmit,
  };
};
