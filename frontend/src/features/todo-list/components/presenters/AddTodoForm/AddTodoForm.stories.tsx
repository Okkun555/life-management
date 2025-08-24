import { Meta, StoryObj } from "@storybook/nextjs";

import { AddTodoForm } from "./AddTodoForm";

const meta: Meta<typeof AddTodoForm> = {
  title: "features/todo-list/AddTodoForm",
  component: AddTodoForm,
};

export default meta;

type Story = StoryObj<typeof AddTodoForm>;

export const Default: Story = {
  args: {
    todoListId: 1,
  },
};
