import { Box, Stack, Button, TextField, DatePicker } from "@/components/mui-material";
import { useProfileForm } from "@/features/profile/hooks/forms";

export const ProfileForm = () => {
  const { control, handleSubmit, onSubmit } = useProfileForm();

  return (
    <Box component="form" onSubmit={handleSubmit(onSubmit)}>
      <Stack gap={3}>
        <TextField name="name" label="アカウント名" control={control} fullWidth />
        <DatePicker name="birthday" label="生年月日" control={control} />

        <Button type="submit" variant="contained" color="secondary">
          登録
        </Button>
      </Stack>
    </Box>
  );
};
