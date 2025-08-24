import { useState } from "react";

import { Tabs } from ".";

import type { Meta, StoryObj } from "@storybook/nextjs";



const meta = {
  title: "Layouts/Tabs",
  component: Tabs,
} satisfies Meta<typeof Tabs>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Default: Story = {
  args: {
    tabItems: {
      "tab1": "Tab1",
      "tab2": "Tab2",
    },
    selected: "tab1",
    handleChangeTab: () => {},
  },
  render: (args) => {
    const [selected, setSelected] = useState(args.selected);

    return <Tabs {...args} selected={selected} handleChangeTab={(_, value) => setSelected(value)} />;
  },
};