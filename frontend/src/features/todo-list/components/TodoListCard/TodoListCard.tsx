import Link from "next/link";

import {
  Box,
  Button,
  Card,
  CardActions,
  CardContent,
  List,
  ListItem,
  Typography,
} from "@/components/mui";

import type { TodoList } from "@/features/todo-list/types";

export type TodoListCardProps = {
  todoList: TodoList;
};

export const TodoListCard = ({ todoList }: TodoListCardProps) => (
  // TODO: ハードコードをやめる
  <Card sx={{ maxWidth: 400, height: "100%" }}>
    <CardContent sx={{ height: "70%" }}>
      <Typography variant="h5" component="div">
        {todoList.title}
      </Typography>
      <Box>
        {todoList.todoListItems.length > 0 ? (
          <List>
            {todoList.todoListItems.map((item, index) => {
              // MEMO: TODOは5件まで表示する
              if (index >= 5) return;
              return (
                <ListItem key={item.id}>
                  {item.status === "completed" ? (
                    <>
                      <span>✅</span>
                      <Typography sx={{ ml: 1 }}>{item.content}</Typography>
                    </>
                  ) : (
                    <>
                      <span>❌</span>
                      <Typography sx={{ ml: 1 }}>{item.content}</Typography>
                    </>
                  )}
                </ListItem>
              );
            })}
          </List>
        ) : (
          <Typography>TODOがありません</Typography>
        )}
      </Box>
    </CardContent>
    <CardActions sx={{ justifyContent: "flex-end" }}>
      <Button>
        <Link href={`/todo-list/${todoList.id}`}>詳細をみる</Link>
      </Button>
    </CardActions>
  </Card>
);
