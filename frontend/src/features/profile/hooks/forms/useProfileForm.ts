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
  avatar?: File | null;
} & FieldValues;

export const useProfileForm = () => {
  const { control, handleSubmit, reset } = useForm<ProfileFormValues>({
    defaultValues: {
      name: "",
      birthday: null,
      sex: SexTypes.secret,
      isPublic: false,
      avatar: null,
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
          birthday: data.birthday ? data.birthday.format("YYYY-MM-DD") : null,
          sex: data.sex,
          isPublic: data.isPublic,
          avatar: data.avatar,
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
  avatar: z
    .custom<File | null>()
    .optional()
    .refine(
      (file) => {
        if (!file) return true;
        const acceptedTypes = ["image/jpeg", "image/png"];
        return acceptedTypes.includes(file.type);
      },
      {
        message: "JPEGまたはPNG形式の画像を選択してください",
      },
    ),
});
