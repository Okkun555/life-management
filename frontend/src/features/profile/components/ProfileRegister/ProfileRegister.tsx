"use client";

import { Box, Typography } from "@/components/mui";

import { ProfileForm } from "../ProfileForm";

export const ProfileRegister = () => {
  return (
    <>
      <Typography variant="h5" component="h2">
        プロフィールの登録
      </Typography>
      <Box sx={{ marginTop: 2 }}>
        <ProfileForm />
      </Box>
    </>
  );
};
