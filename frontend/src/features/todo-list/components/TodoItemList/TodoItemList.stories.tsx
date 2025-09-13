import { generateEmptyTodoList, generateTodoList } from "@/mock/factories/todoListGenerator";

import { TodoItemList } from "./TodoItemList";

import type { Meta, StoryObj } from "@storybook/nextjs";

const meta: Meta<typeof TodoItemList> = {
  title: "features/todo-list/TodoItemList",
  component: TodoItemList,
};

export default meta;

type Story = StoryObj<typeof TodoItemList>;

export const Default: Story = {
  args: {
    todoList: generateTodoList(),
  },
};

export const Empty: Story = {
  args: {
    todoList: generateEmptyTodoList(),
  },
};
