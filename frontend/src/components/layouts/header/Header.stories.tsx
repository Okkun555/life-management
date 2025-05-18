import { Meta, StoryObj } from "@storybook/react";
import { Header } from "./Header";
import styled from "styled-components";

/**
 * ヘッダーコンポーネント
 * 
 * アプリケーションの上部に表示されるナビゲーションバーです。
 * アプリケーション名と各ページへのリンクを提供します。
 */
const meta: Meta<typeof Header> = {
  title: "Components/Header",
  component: Header,
  parameters: {
    layout: "fullscreen",
  },
  decorators: [
    (Story) => (
      <Container>
        <Story />
      </Container>
    ),
  ],
};

const Container = styled.div`
  width: 100%;
`;

export default meta;
type Story = StoryObj<typeof Header>;

/**
 * デフォルトのヘッダー表示
 */
export const Default: Story = {
  // usePathname() を模倣してデフォルト状態（ホームページ）を表示
  parameters: {
    nextjs: {
      navigation: {
        pathname: "/",
      },
    },
  },
};

/**
 * タスク一覧ページが選択された状態のヘッダー
 */
export const TaskListActive: Story = {
  parameters: {
    nextjs: {
      navigation: {
        pathname: "/task-list",
      },
    },
  },
};
