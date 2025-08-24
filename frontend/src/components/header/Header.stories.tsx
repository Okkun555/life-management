import { Header } from ".";

import type { Meta, StoryObj } from "@storybook/nextjs";


const meta = {
  title: "Layouts/Header",
  component: Header,
} satisfies Meta<typeof Header>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Default: Story = {
  args: {
    isOpenSidebar: false,
    handleChangeSidebar: () => {},
  },
};