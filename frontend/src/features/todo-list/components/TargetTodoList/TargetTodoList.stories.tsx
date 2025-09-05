import { Meta, StoryObj } from "@storybook/nextjs";

import { TargetTodoList } from "./TargetTodoList";

const meta: Meta<typeof TargetTodoList> = {
  title: "features/todo-list/TargetTodoList",
  component: TargetTodoList,
};

export default meta;

type Story = StoryObj<typeof TargetTodoList>;

export const Default: Story = {
  args: {
    todoList: {
      id: 1,
      title: "2025/08/23",
      todoListItems: [
        {
          id: 1,
          content: "買い物",
          status: "pending",
        },
        {
          id: 2,
          content: "勉強",
          status: "completed",
        },
      ],
      author: {
        id: 1,
        name: "test",
      },
    },
  },
};

export const Loading: Story = {
  args: {
    isLoading: true,
    todoList: undefined,
  },
};

export const EmptyTodoItem: Story = {
  args: {
    todoList: {
      id: 1,
      title: "2025/08/23",
      todoListItems: [],
      author: {
        id: 1,
        name: "test",
      },
    },
    isLoading: false,
  },
};
