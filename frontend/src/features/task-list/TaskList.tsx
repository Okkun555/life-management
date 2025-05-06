"use client";

import { useState } from "react";
import { Task } from "./Task";
import { TaskForm } from "./TaskForm";
import { TaskItem } from "@/types/task";

export function TaskList() {
  // モックデータ
  const [tasks, setTasks] = useState<TaskItem[]>([
    { id: "1", title: "買い物に行く", completed: false },
    { id: "2", title: "レポートを書く", completed: true },
    { id: "3", title: "部屋の掃除", completed: false },
  ]);

  // タスクの追加
  const addTask = (title: string) => {
    const newTask: TaskItem = {
      id: Date.now().toString(),
      title,
      completed: false,
    };
    setTasks([...tasks, newTask]);
  };

  // タスクの削除
  const deleteTask = (id: string) => {
    setTasks(tasks.filter(task => task.id !== id));
  };

  // タスクの編集
  const editTask = (id: string, title: string) => {
    setTasks(
      tasks.map(task => (task.id === id ? { ...task, title } : task))
    );
  };

  // タスクの完了状態の切り替え
  const toggleComplete = (id: string) => {
    setTasks(
      tasks.map(task =>
        task.id === id ? { ...task, completed: !task.completed } : task
      )
    );
  };

  return (
    <div className="task-list">
      <TaskForm onAddTask={addTask} />
      
      <div className="tasks-container mt-6">
        {tasks.length === 0 ? (
          <p className="text-gray-500">タスクはありません</p>
        ) : (
          tasks.map(task => (
            <Task
              key={task.id}
              task={task}
              onDelete={deleteTask}
              onEdit={editTask}
              onToggleComplete={toggleComplete}
            />
          ))
        )}
      </div>
    </div>
  );
} 