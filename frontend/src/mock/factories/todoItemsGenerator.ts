import type { TodoItem } from "@/features/todo-list/types";

/**
 * TodoItemを生成する（奇数番号はpending、偶数番号はcompleted）
 * @param count 生成するTodoItemの数
 * @returns
 */
export const generateTodoItems = (count: number = 2): TodoItem[] => {
  return Array.from({ length: count }, (_, index) => ({
    id: index + 1,
    content: `Todo Item ${index + 1}`,
    status: index % 2 === 0 ? "pending" : "completed",
  }));
};
