import { useChangeTodoItemStatus } from "@/features/todo-list/hooks/useChangeTodoItemStatus";
import { useDeleteTodoItem } from "@/features/todo-list/hooks/useDeleteTodoItem";
import { useFetchCurrentTodoList } from "@/hooks/api/todo-list/useTodoApi";

import { CurrentTodoList } from ".";

export const CurrentTodoListAdapter = () => {
  const { todoList = undefined, isLoading } = useFetchCurrentTodoList();

  const { handleDeleteTodoItem } = useDeleteTodoItem(todoList?.id ?? 0);
  const { handleChangeTodoItemStatus } = useChangeTodoItemStatus(todoList?.id ?? 0);

  return (
    <CurrentTodoList
      isLoading={isLoading}
      todoList={todoList}
      handleDeleteTodoItem={handleDeleteTodoItem}
      handleChangeTodoItemStatus={handleChangeTodoItemStatus}
    />
  );
};
