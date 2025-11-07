import { useForm } from "react-hook-form";

import { SexType } from "../../types";

type ProfileForm = {
  name: string;
  birthday: Date | null;
  sex: SexType;
  isPublic: boolean;
};

export const useProfileForm = () => {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<ProfileForm>({
    defaultValues: {
      name: "",
      birthday: null,
      sex: "secret",
      isPublic: false,
    },
  });

  return {
    register,
    handleSubmit,
    errors,
  };
};
