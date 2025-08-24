import { LoggedInLayout } from ".";

import type { Meta, StoryObj } from "@storybook/nextjs";


const meta = {
  title: "Layouts/LoggedInLayout",
  component: LoggedInLayout,
} satisfies Meta<typeof LoggedInLayout>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Default: Story = {
  args: {
    children: <div>ここに各コンテンツが入ります。</div>,
  },
};