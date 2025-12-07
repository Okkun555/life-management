"use client";

import SettingsIcon from "@mui/icons-material/Settings";
import React, { useState } from "react";

import { Typography, Box} from "@/components/mui-material";
import { Tabs } from "@/components/tabs";


import { type SettingTabItem, settingTabItems } from "../types";

export const Setting = () => {
  const [selected, setSelected] = useState<SettingTabItem>("bodyPart");

  const handleChangeTab = (_: React.SyntheticEvent, value: SettingTabItem) => setSelected(value);


  return (
    <>
      <Box display='flex' alignItems='center'>
        <SettingsIcon />
        <Typography variant="h5" component="h2">マスター設定</Typography>
      </Box>
      <Tabs tabItems={settingTabItems} selected={selected} handleChangeTab={handleChangeTab} />
    </>
  );
};