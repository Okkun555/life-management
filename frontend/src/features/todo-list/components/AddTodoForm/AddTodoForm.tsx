import { TextFieldController } from "@/components/forms/text-field";
import { Box, Button, Grid, Typography } from "@/components/mui";
import { useAddTodoForm } from "@/features/todo-list/hooks/form/useAddTodoForm";

type AddTodoFormProps = {
  todoListId: number;
};

export const AddTodoForm = ({ todoListId }: AddTodoFormProps) => {
  const { register, handleSubmit, onSubmit, errors } = useAddTodoForm(todoListId);

  return (
    <Box component="form" onSubmit={handleSubmit(onSubmit)} sx={{ mt: 2 }}>
      <Typography component="div">あなたが今日やるべきことは何ですか？</Typography>
      <Grid container spacing={2} alignItems="center">
        <Grid size={10}>
          <TextFieldController
            registration={register("content")}
            textField={{ fieldWrapper: { label: "", errorMessage: errors.content?.message } }}
          />
        </Grid>
        <Grid size={2}>
          <Button type="submit" variant="contained" color="secondary" size="large">
            追加
          </Button>
        </Grid>
      </Grid>
    </Box>
  );
};
