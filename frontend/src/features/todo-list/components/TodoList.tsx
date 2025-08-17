"use client";

import { useState } from "react";

import { Tabs } from "@/components/layouts/tabs";
import { Box } from "@/components/mui";

import { AllTodoList } from "./AllTodoList";
import { CurrentTodo } from "./CurrentTodo";

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
        { selected === "currentTodo" && <CurrentTodo /> }
        { selected === "all" && <AllTodoList /> }
      </Box>
    </>
  );
};