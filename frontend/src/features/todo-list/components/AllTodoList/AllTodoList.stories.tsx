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
    todoLists: [],
    isLoading: false,
  },
};

export const Loading: Story = {
  args: {
    todoLists: [],
    isLoading: true,
  },
};
