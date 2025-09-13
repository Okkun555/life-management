import DeleteIcon from "@mui/icons-material/Delete";

import {
  Box,
  Checkbox,
  IconButton,
  List,
  ListItem,
  ListItemButton,
  ListItemIcon,
  ListItemText,
  Paper,
  Typography,
} from "@/components/mui";

import { TodoProgressBar } from "../TodoProgressBar";

import type { TodoItem, TodoList } from "@/features/todo-list/types";
import type { ChangeTodoItemStatusParams } from "@/hooks/api/todo-list/type";

type TodoItemListProps = {
  todoList: TodoList;
  handleChangeTodoItemStatus?: (_arg: ChangeTodoItemStatusParams) => Promise<void>;
  handleDeleteTodoItem?: (_todoItemId: TodoItem["id"]) => void;
};

export const TodoItemList = ({
  todoList,
  handleDeleteTodoItem = undefined,
  handleChangeTodoItemStatus = undefined,
}: TodoItemListProps) => {
  if (todoList.todoListItems.length === 0) {
    return (
      <Typography>
        登録されたTODOはありません。
        {handleChangeTodoItemStatus && handleDeleteTodoItem && "TODOを登録しましょう！"}
      </Typography>
    );
  }

  return (
    <Paper>
      <Box sx={{ pt: 2, pr: 3, pl: 3 }}>
        <TodoProgressBar value={todoList.completedRate} />
      </Box>
      <List sx={{ width: "100%" }}>
        {todoList.todoListItems.map((item) => {
          if (!handleDeleteTodoItem || !handleChangeTodoItemStatus) {
            return (
              <ListItem key={item.id}>
                <ListItemIcon>
                  <Checkbox
                    edge="start"
                    checked={item.status === "completed"}
                    tabIndex={-1}
                    disabled
                  />
                </ListItemIcon>
                <ListItemText
                  sx={{
                    textDecoration: item.status === "completed" ? "line-through" : "none",
                    color: item.status === "completed" ? "text.secondary" : "text.primary",
                  }}
                >
                  {item.content}
                </ListItemText>
              </ListItem>
            );
          }

          return (
            <ListItem
              key={item.id}
              secondaryAction={
                <IconButton edge="end" onClick={() => handleDeleteTodoItem(item.id)}>
                  <DeleteIcon />
                </IconButton>
              }
              disablePadding
            >
              <ListItemButton
                onClick={() =>
                  handleChangeTodoItemStatus({
                    id: item.id,
                    status: item.status === "completed" ? "pending" : "completed",
                  })
                }
                dense
              >
                <ListItemIcon>
                  <Checkbox
                    edge="start"
                    checked={item.status === "completed"}
                    tabIndex={-1}
                    disableRipple
                  />
                </ListItemIcon>
                <ListItemText
                  sx={{
                    textDecoration: item.status === "completed" ? "line-through" : "none",
                    color: item.status === "completed" ? "text.secondary" : "text.primary",
                  }}
                >
                  {item.content}
                </ListItemText>
              </ListItemButton>
            </ListItem>
          );
        })}
      </List>
    </Paper>
  );
};
