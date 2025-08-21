"use client";

import { useState } from "react";

import { Box, Toolbar } from "@/components/mui";

import { Header } from "@/components/header";
import { Sidebar } from "@/components/sidebar";

type Props = {
  children: React.ReactNode;
}

const MINI_DRAWER_WIDTH = 64;

export function LoggedInLayout({ children }: Props) {
  const [isOpenSidebar, setIsOpenSidebar] = useState(true);
  const handleChangeSidebar = (value: boolean) => setIsOpenSidebar(value);

  return (
    <Box
      sx={{
        position: "relative",
        display: "flex",
        overflow: "hidden",
        height: "100vh",
        width: "100%",
      }}
    >
      <Header isOpenSidebar={isOpenSidebar} handleChangeSidebar={handleChangeSidebar} />
      {isOpenSidebar && <Sidebar />}
      <Box
        sx={{
          display: "flex",
          flexDirection: "column",
          flex: 1,
          minWidth: 0,
          marginLeft: { 
            xs: 0, 
            sm: isOpenSidebar ? `${MINI_DRAWER_WIDTH}px` : undefined
          },
          transition: (theme) => theme.transitions.create(["margin"], {
            easing: theme.transitions.easing.sharp,
            duration: theme.transitions.duration.enteringScreen,
          }),
        }}
      >
        <Toolbar sx={{ displayPrint: "none" }} />
        <Box 
          component="main"
          sx={{
            display: "flex",
            flexDirection: "column",
            flex: 1,
            overflow: "auto",
            padding: 2,
          }}
        >
          {children}
        </Box>
      </Box>
    </Box>
  );
}