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
    todoItems: [
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
  },
};

export const Empty: Story = {
  args: {
    todoItems: [],
  },
};
