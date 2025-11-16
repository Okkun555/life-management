import { zodResolver } from "@hookform/resolvers/zod";
import dayjs from "dayjs";
import { useCallback } from "react";
import { FieldValues, useForm } from "react-hook-form";
import { z } from "zod";

import { SexTypes, type SexType } from "@/features/profile/types";
import { useCreateProfile } from "@/hooks/api/profile/useProfileApi";
import { required } from "@/libs/zod/messages";

import type { Dayjs } from "dayjs";

type ProfileFormValues = {
  name: string;
  birthday: Dayjs | null;
  sex: SexType;
  isPublic: boolean;
} & FieldValues;

export const useProfileForm = () => {
  const { control, handleSubmit, reset } = useForm<ProfileFormValues>({
    defaultValues: {
      name: "",
      birthday: null,
      sex: SexTypes.secret,
      isPublic: false,
    },
    resolver: zodResolver(profileSchema),
    reValidateMode: "onSubmit",
  });

  const { trigger } = useCreateProfile();
  const onSubmit = useCallback(
    async (data: ProfileFormValues) => {
      await trigger({
        user: {
          name: data.name,
        },
        profile: {
          birthday: data.birthday,
          sex: data.sex,
          isPublic: data.isPublic,
        },
      });
      reset();
    },
    [trigger, reset],
  );

  return { control, handleSubmit, onSubmit };
};

const profileSchema = z.object({
  name: z.string().min(1, { message: required("アカウント名") }),
  birthday: z.custom<Dayjs | null>((val) => {
    return val === null || dayjs.isDayjs(val);
  }),
  sex: z.enum(["secret", "man", "woman"]),
  isPublic: z.boolean(),
});
