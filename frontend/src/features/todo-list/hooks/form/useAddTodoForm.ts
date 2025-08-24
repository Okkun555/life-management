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
  const onSubmit = useCallback(
    async (data: AddTodoFormValues) => {
      const response = await trigger(data);
      console.log(response);
    },
    [trigger],
  );

  return {
    register,
    handleSubmit,
    onSubmit,
  };
};
