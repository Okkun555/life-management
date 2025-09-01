import { useState } from "react";

import { useChangeTodoItemStatus } from "@/features/todo-list/hooks/useChangeTodoItemStatus";
import { useDeleteTodoItem } from "@/features/todo-list/hooks/useDeleteTodoItem";
import { ChangeTodoItemStatusParams } from "@/hooks/api/todo-list/type";
import { useFetchCurrentTodoList } from "@/hooks/api/todo-list/useTodoApi";

import { CurrentTodoList } from ".";

export const CurrentTodoListAdapter = () => {
  const [activeConfetti, setActiveConfetti] = useState(false);
  const { todoList = undefined, isLoading } = useFetchCurrentTodoList();

  const { handleDeleteTodoItem } = useDeleteTodoItem(todoList?.id ?? 0);
  const { onSubmitChangeTodoItemStatus } = useChangeTodoItemStatus(todoList?.id ?? 0);

  const handleChangeTodoItemStatus = async (arg: ChangeTodoItemStatusParams) => {
    const res = await onSubmitChangeTodoItemStatus(arg);
    if (res && res.status === "completed") {
      setActiveConfetti(true);
      setTimeout(() => {
        setActiveConfetti(false);
      }, 3000);
    }
  };

  return (
    <CurrentTodoList
      isLoading={isLoading}
      todoList={todoList}
      handleDeleteTodoItem={handleDeleteTodoItem}
      handleChangeTodoItemStatus={handleChangeTodoItemStatus}
      activeConfetti={activeConfetti}
    />
  );
};
