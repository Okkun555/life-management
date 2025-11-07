import { TextFieldController } from "@/components/forms/text-field";
import { Box, Button } from "@/components/mui";
import { useProfileForm } from "@/features/profile/hooks/forms";

export const ProfileForm = () => {
  const { register, handleSubmit, errors } = useProfileForm();

  return (
    <Box component="form">
      <TextFieldController
        registration={register("name")}
        textField={{
          fieldWrapper: { label: "アカウント名", errorMessage: errors.birthday?.message },
        }}
      />

      <Button type="submit" variant="contained" color="secondary" size="large">
        登録
      </Button>
    </Box>
  );
};
