"use client";

import { useState } from "react";

import { Box } from "@/components/mui";
import { Tabs } from "@/components/tabs";

import { AllTodoList } from "./AllTodoList";
import { CurrentTodoListAdapter } from "./current-todo-list";

const todoListTabItems = {
  currentTodo: "本日のTODO",
  all: "全てのTODO",
};
type TodoListTabItem = keyof typeof todoListTabItems;

export const TodoList = () => {
  const [selected, setSelected] = useState<TodoListTabItem>("currentTodo");

  const handleChangeTab = (_: React.SyntheticEvent, value: TodoListTabItem) => setSelected(value);


  return (
    <>
      <Tabs tabItems={todoListTabItems} selected={selected} handleChangeTab={handleChangeTab} />
      <Box sx={{ mt: 2 }}>
        { selected === "currentTodo" && <CurrentTodoListAdapter /> }
        { selected === "all" && <AllTodoList /> }
      </Box>
    </>
  );
};