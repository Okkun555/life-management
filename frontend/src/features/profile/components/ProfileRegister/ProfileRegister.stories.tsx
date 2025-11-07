import { Meta, StoryObj } from "@storybook/nextjs";

import { ProfileRegister } from "./ProfileRegister";

const meta: Meta<typeof ProfileRegister> = {
  title: "profile/ProfileRegister",
  component: ProfileRegister,
};

export default meta;

type Story = StoryObj<typeof ProfileRegister>;

export const Default: Story = {};
