import { AllTodoList } from "./AllTodoList";

import type { Meta, StoryObj } from "@storybook/nextjs";

const meta: Meta<typeof AllTodoList> = {
  title: "features/todo-list/AllTodoList",
  component: AllTodoList,
};

export default meta;

type Story = StoryObj<typeof AllTodoList>;

export const Default: Story = {
  args: {
    todoLists: [
      {
        id: 1,
        title: "2025/08/23",
        todoListItems: [
          {
            id: 1,
            content: "テスト1",
            status: "pending",
          },
        ],
        author: {
          id: 1,
          name: "テストユーザー",
        },
      },
      {
        id: 2,
        title: "2025/08/24",
        todoListItems: [],
        author: {
          id: 1,
          name: "テストユーザー",
        },
      },
      {
        id: 3,
        title: "2025/08/25",
        todoListItems: [
          {
            id: 1,
            content: "テスト1",
            status: "pending",
          },
          {
            id: 2,
            content: "テスト2",
            status: "completed",
          },
          {
            id: 3,
            content: "テスト3",
            status: "pending",
          },
        ],
        author: {
          id: 1,
          name: "テストユーザー",
        },
      },
    ],
    isLoading: false,
  },
};

export const Loading: Story = {
  args: {
    todoLists: [],
    isLoading: true,
  },
};
