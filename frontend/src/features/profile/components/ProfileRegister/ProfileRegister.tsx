"use client";

import {
  Box,
  Button,
  Container,
  DatePicker,
  SelectField,
  Stack,
  SwitchField,
  TextField,
  Typography,
} from "@/components/mui-material";
import { useProfileForm } from "@/features/profile/hooks/forms";
import { SexTypes } from "@/features/profile/types";

export const ProfileRegister = () => {
  const { control, handleSubmit, onSubmit } = useProfileForm();
  const sexOptions = [
    { id: SexTypes.man, label: "男性" },
    { id: SexTypes.woman, label: "女性" },
    { id: SexTypes.secret, label: "その他" },
  ];

  return (
    <Container>
      <Typography variant="h5" component="h2">
        プロフィールの新規作成
      </Typography>

      <Box component="form" onSubmit={handleSubmit(onSubmit)}>
        <SwitchField name="isPublic" label="プロフィールを公開する" control={control} />
        <Stack gap={3}>
          <TextField name="name" label="アカウント名" control={control} />
          <DatePicker name="birthday" label="生年月日" control={control} />
          <SelectField name="sex" label="性別" control={control} options={sexOptions} />
          <Button variant="contained" color="secondary" type="submit">
            作成する
          </Button>
        </Stack>
      </Box>
    </Container>
  );
};
