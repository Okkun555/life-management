import type { Meta, StoryObj } from '@storybook/nextjs';

import { Sidebar } from ".";

const meta = {
  title: "Layouts/Sidebar",
  component: Sidebar,
} satisfies Meta<typeof Sidebar>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Default: Story = {}