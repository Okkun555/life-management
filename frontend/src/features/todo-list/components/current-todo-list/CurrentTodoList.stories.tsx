import { CurrentTodoList } from "./CurrentTodoList";

import type { Meta, StoryObj } from "@storybook/nextjs";

const meta: Meta<typeof CurrentTodoList> = {
  title: "features/todo-list/CurrentTodoList",
  component: CurrentTodoList,
};

export default meta;

type Story = StoryObj<typeof CurrentTodoList>;

export const Default: Story = {
  args: {
    isLoading: false,
    todoList: {
      id: 1,
      title: "2025/08/23",
      todoListItems: [
        {
          id: 1,
          content: "買い物",
          status: "pending",
          author: {
            id: 1,
            name: "山田太郎",
          },
        },
        {
          id: 2,
          content: "勉強",
          status: "pending",
          author: {
            id: 2,
            name: "山田花子",
          },
        },
      ],
    },
  },
};

export const Loading: Story = {
  args: {
    isLoading: true,
    todoList: undefined,
  },
};

export const Error: Story = {
  args: {
    isLoading: false,
    todoList: undefined,
  },
};
