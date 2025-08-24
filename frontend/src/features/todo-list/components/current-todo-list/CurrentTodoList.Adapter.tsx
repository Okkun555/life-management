import { useFetchCurrentTodoList } from "@/hooks/api/todo-list/useTodoApi";

import { CurrentTodoList } from ".";

export const CurrentTodoListAdapter = () => {
  const { todoList = undefined, isLoading } = useFetchCurrentTodoList();

  return <CurrentTodoList isLoading={isLoading} todoList={todoList} />;
};
