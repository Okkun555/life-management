import type { Meta, StoryObj } from "@storybook/react";
import { MainContainer } from "./MainContainer";

const meta = {
  title: "Components/Layouts/Container/MainContainer",
  component: MainContainer,
  parameters: {
    layout: "centered",
  },
  tags: ["autodocs"],
} satisfies Meta<typeof MainContainer>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {
  args: {
    children: <div>コンテンツがここに表示されます</div>,
  },
};

export const WithLongContent: Story = {
  args: {
    children: (
      <div>
        <h1>長いコンテンツの例</h1>
        <p>これは長いコンテンツを表示した場合のデモです。</p>
        <p>コンテナがどのように表示されるかを確認できます。</p>
      </div>
    ),
  },
}; 