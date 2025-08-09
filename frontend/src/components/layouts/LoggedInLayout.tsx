"use client";

import { useRef, useState } from "react";

import { Box, Toolbar } from "@/components/mui";

import { Header } from "./header";
import { Sidebar } from "./sidebar";

import type { SidebarType } from "./sidebar/Sidebar";

type Props = {
  children: React.ReactNode;
}

const DRAWER_WIDTH = 240;
const MINI_DRAWER_WIDTH = 64;

export function LoggedInLayout({ children }: Props) {
  const layoutRef = useRef<HTMLDivElement>(null);

  const [isSidebarOpen, setIsSidebarOpen] = useState<SidebarType>("mini");
  const handleSidebarOpen= () => setIsSidebarOpen("full");
  const handleSidebarClose = () => setIsSidebarOpen("mini");

  return (
    <Box
      ref={layoutRef}
      sx={{
        position: "relative",
        display: "flex",
        overflow: "hidden",
        height: "100vh",
        width: "100%",
      }}
    >
      <Header onMenuClick={handleSidebarOpen} />
      <Sidebar 
        container={layoutRef?.current ?? undefined} 
        open={isSidebarOpen} 
        onClose={handleSidebarClose} 
      />
      <Box
        sx={{
          display: "flex",
          flexDirection: "column",
          flex: 1,
          minWidth: 0,
          marginLeft: { 
            xs: 0, 
            sm: isSidebarOpen ? `${DRAWER_WIDTH}px` : `${MINI_DRAWER_WIDTH}px`
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