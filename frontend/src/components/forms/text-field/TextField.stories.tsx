import { Meta, StoryObj } from "@storybook/react";

import { TextField } from "./TextField";

const meta: Meta<typeof TextField> = {
  title: "Layouts/Forms/TextField",
  component: TextField,
};

export default meta;

type Story = StoryObj<typeof TextField>;

export const Default: Story = {
  args: {
    fieldWrapper: {
      label: "名前",
    },
    muiTextField: {
      name: "name",
    },
  },
};

export const Disabled: Story = {
  args: {
    fieldWrapper: {
      label: "名前(Disabled)",
    },
    muiTextField: {
      name: "name",
      disabled: true,
    },
  },
};