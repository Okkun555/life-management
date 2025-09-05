import DeleteIcon from "@mui/icons-material/Delete";

import {
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

import type { TodoItem } from "@/features/todo-list/types";
import type { ChangeTodoItemStatusParams } from "@/hooks/api/todo-list/type";

type TodoItemListProps = {
  todoItems: TodoItem[];
  handleChangeTodoItemStatus: (_arg: ChangeTodoItemStatusParams) => Promise<void>;
  handleDeleteTodoItem: (_todoItemId: TodoItem["id"]) => void;
};

export const TodoItemList = ({
  todoItems,
  handleDeleteTodoItem,
  handleChangeTodoItemStatus,
}: TodoItemListProps) => {
  if (todoItems.length === 0) {
    return (
      <Typography>
        登録されたTODOはありません。フォームからやるべきことを登録しましょう！
      </Typography>
    );
  }

  return (
    <Paper>
      <List sx={{ width: "100%" }}>
        {todoItems.map((item) => (
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
        ))}
      </List>
    </Paper>
  );
};
