import { Meta, StoryObj } from "@storybook/nextjs";

import { TodoProgressBar } from ".";

const meta: Meta<typeof TodoProgressBar> = {
  title: "features/todo-list/TodoProgressBar",
  component: TodoProgressBar,
};

export default meta;

type Story = StoryObj<typeof TodoProgressBar>;

export const Default: Story = {
  args: {
    value: 0,
  },
};

export const Half: Story = {
  args: {
    value: 50,
  },
};

export const Full: Story = {
  args: {
    value: 100,
  },
};
