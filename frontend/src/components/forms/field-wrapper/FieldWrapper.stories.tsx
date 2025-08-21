import type { Meta, StoryObj } from '@storybook/nextjs';

import { FieldWrapper } from ".";

const meta = {
  title: "Layouts/Forms/FieldWrapper",
  component: FieldWrapper,
} satisfies Meta<typeof FieldWrapper>;

export default meta;

type Story = StoryObj<typeof meta>;

export const Default: Story = {
  args: {
    label: "入力フォーム",
    required: false,
    children: <div>テスト</div>,
  },
}

export const Required: Story = {
  args: {
    label: "入力フォーム",
    required: true,
    children: <div>テスト</div>,
  },
}

export const Error: Story = {
  args: {
    label: "入力フォーム",
    required: false,
    errorMessage: "エラーメッセージ",
    children: <div>テスト</div>,
  },
}