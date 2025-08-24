import { zodResolver } from "@hookform/resolvers/zod";
import { useCallback } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";

import { useAddTodoItem } from "@/hooks/api/todo-list/useTodoItemApi";

export type AddTodoFormValues = {
  content: string;
};

export const useAddTodoForm = (todoListId: number) => {
  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
  } = useForm<AddTodoFormValues>({
    defaultValues: {
      content: "",
    },
    resolver: zodResolver(addTodoItemSchema),
  });

  const { trigger } = useAddTodoItem(todoListId);
  // TODO: 楽観的更新処理を入れてみる？
  const onSubmit = useCallback(
    async (data: AddTodoFormValues) => {
      await trigger(data);
      reset();
    },
    [trigger, reset],
  );

  return {
    register,
    handleSubmit,
    onSubmit,
    errors,
  };
};

const addTodoItemSchema = z.object({
  content: z
    .string()
    .min(1, { message: "内容を入力してください" })
    .max(100, { message: "100文字以内で入力してください" }),
});
