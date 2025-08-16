import { useState } from "react";

import { Box, Tabs, Tab } from "@/components/mui";

const todoListTabItems = {
  currentTodo: "本日のTODO",
  all: "全てのTODO",
};

type TodoListTabItem = keyof typeof todoListTabItems;

export const TodoListTab = () => {
  const [selected, setSelected] = useState<TodoListTabItem>("currentTodo");

  const handleChangeTab = (event: React.SyntheticEvent, value: TodoListTabItem) => setSelected(value);

  return (
    <Box sx={{ borderBottom: 1, borderColor: "divider" }}>
      <Tabs value={selected} onChange={handleChangeTab} textColor="secondary" indicatorColor="secondary">
        {Object.entries(todoListTabItems).map(([key, value]) => (
          <Tab key={key} label={value} value={key} />
        ))}
      </Tabs>
    </Box>
  );
};