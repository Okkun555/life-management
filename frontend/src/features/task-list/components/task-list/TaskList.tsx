"use client";
import { TaskItem } from "@/types/task";
import { useState } from "react";
import { FormControl, Input } from "@/components/elements";

export function TaskList() {
  const [tasks, setTasks] = useState<TaskItem[]>([
    { id: "1", title: "買い物に行く", completed: false },
    { id: "2", title: "レポートを書く", completed: true },
    { id: "3", title: "部屋の掃除", completed: false },
  ]);

  return (
    <div>
      <form>
        <FormControl title="Task">
          <Input name="task" type="text"  />
        </FormControl>
      </form>
    </div>
  );
}