import { useFetchAllTodoList } from "@/hooks/api/todo-list/useTodoApi";

import { AllTodoList } from "./AllTodoList";

export const AllTodoListAdapter = () => {
  const { todoLists, isLoading } = useFetchAllTodoList();

  console.log(todoLists);

  return <AllTodoList todoLists={todoLists ?? []} isLoading={isLoading} />;
};
