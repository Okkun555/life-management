import { Meta, StoryObj } from "@storybook/nextjs";

import { TodoListCard } from ".";

const meta: Meta<typeof TodoListCard> = {
  title: "features/todo-list/TodoListCard",
  component: TodoListCard,
};

export default meta;

type Story = StoryObj<typeof TodoListCard>;

export const Default: Story = {
  args: {
    todoList: {
      id: 1,
      title: "2025/08/23",
      todoListItems: [
        {
          id: 1,
          content: "買い物",
          status: "completed",
        },
        {
          id: 2,
          content: "買い物2",
          status: "pending",
        },
        {
          id: 3,
          content: "買い物3",
          status: "completed",
        },
        {
          id: 4,
          content: "買い物4",
          status: "pending",
        },
        {
          id: 5,
          content: "買い物5",
          status: "pending",
        },
        {
          id: 6,
          content: "買い物6",
          status: "pending",
        },
        {
          id: 7,
          content: "買い物7",
          status: "pending",
        },
      ],
      author: {
        id: 1,
        name: "山田太郎",
      },
    },
  },
};
