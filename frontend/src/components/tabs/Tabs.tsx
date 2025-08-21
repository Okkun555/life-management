"use client";

import { Box, Tabs as MuiTabs, Tab } from "@/components/mui";

type Props<T> = {
  tabItems: { [key: string]: string };
  selected: T;
  handleChangeTab: (_event: React.SyntheticEvent, _value: T) => void;
}

export default function Tabs<T extends string>({ tabItems, selected, handleChangeTab }: Props<T>) {

  return (
    <Box sx={{ borderBottom: 1, borderColor: "divider" }}>
      <MuiTabs value={selected} onChange={handleChangeTab} textColor="secondary" indicatorColor="secondary">
        {Object.entries(tabItems).map(([key, value]) => (
          <Tab key={key} label={value} value={key} />
        ))}
      </MuiTabs>
    </Box>
  );
}