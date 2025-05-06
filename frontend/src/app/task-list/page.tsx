import { TaskList } from '@/features/task-list/TaskList';

export const metadata = {
  title: 'タスクリスト | Life Management',
  description: 'タスクの一覧を管理するページです',
};

export default function TaskListPage() {
  return (
    <main className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-6">タスク一覧</h1>
      <TaskList />
    </main>
  );
} 