import useSWRMutation from "swr/mutation";

import { TodoList } from "@/features/todo-list/types";
import { postRequest } from "@/libs/api/fetcher";
import { path } from "@/libs/api/path";

export const useAddTodoItem = (id: TodoList["id"]) => {
  const { trigger, isMutating } = useSWRMutation(path.addTodoItem(id), postRequest);

  return { trigger, isMutating };
};
