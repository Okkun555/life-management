"use client";

import type { TaskItem } from "@/types/task";
import { useState } from "react";



type TaskProps = {
  task: TaskItem;
  onDelete: (id: string) => void;
  onEdit: (id: string, title: string) => void;
  onToggleComplete: (id: string) => void;
}

export function Task({ task, onDelete, onEdit, onToggleComplete }: TaskProps) {
  const [isEditing, setIsEditing] = useState(false);
  const [editedTitle, setEditedTitle] = useState(task.title);

  const handleEdit = () => {
    if (editedTitle.trim() !== "") {
      onEdit(task.id, editedTitle);
      setIsEditing(false);
    }
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === "Enter") {
      handleEdit();
    } else if (e.key === "Escape") {
      setIsEditing(false);
      setEditedTitle(task.title);
    }
  };

  return (
    <div className={`task-item p-4 mb-2 border rounded flex items-center ${task.completed ? "bg-gray-100" : ""}`}>
      <input
        type="checkbox"
        checked={task.completed}
        onChange={() => onToggleComplete(task.id)}
        className="mr-3"
      />
      
      {isEditing ? (
        <input
          type="text"
          value={editedTitle}
          onChange={(e) => setEditedTitle(e.target.value)}
          onBlur={handleEdit}
          onKeyDown={handleKeyDown}
          className="flex-grow p-1 border rounded"
          autoFocus
        />
      ) : (
        <span 
          className={`flex-grow ${task.completed ? "line-through text-gray-500" : ""}`}
          onClick={() => setIsEditing(true)}
        >
          {task.title}
        </span>
      )}
      
      <div className="task-actions ml-4">
        {!isEditing && (
          <>
            <button
              onClick={() => setIsEditing(true)}
              className="text-blue-500 mr-2"
            >
              編集
            </button>
            <button
              onClick={() => onDelete(task.id)}
              className="text-red-500"
            >
              削除
            </button>
          </>
        )}
      </div>
    </div>
  );
} 