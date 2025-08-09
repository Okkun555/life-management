import TaskAltIcon from "@mui/icons-material/TaskAlt";
import Link from "next/link";

import { 
  Box, 
  Drawer, 
  List, 
  ListItem, 
  ListItemButton, 
  ListItemIcon, 
  ListItemText, 
  Toolbar,
  Tooltip
} from "@/components/mui";

export type SidebarType = "full" | "mini";

type Props = {
  type: SidebarType;
  onClose: () => void;
}

const DRAWER_WIDTH = 240;
const MINI_DRAWER_WIDTH = 120;

const menuItems = [
  {
    text: "タスクリスト",
    icon: <TaskAltIcon />,
    href: "/task-list"
  }
];

export function Sidebar({ type, onClose }: Props) {
  const drawer = (
    <Box>
      <Toolbar />
      <List>
        {menuItems.map((item) => (
          <ListItem key={item.text} disablePadding>
            <Tooltip title={!open ? item.text : ""} placement="right">
              <ListItemButton 
                component={Link} 
                href={item.href} 
                onClick={onClose}
                sx={{
                  minHeight: 48,
                  justifyContent: type === "full" ? "initial" : "center",
                  px: 2.5,
                }}
              >
                <ListItemIcon
                  sx={{
                    minWidth: 0,
                    mr: type === "full" ? 3 : "auto",
                    justifyContent: "center",
                  }}
                >
                  {item.icon}
                </ListItemIcon>
                <ListItemText 
                  primary={item.text} 
                  sx={{ opacity: type === "full" ? 1 : 0 }}
                />
              </ListItemButton>
            </Tooltip>
          </ListItem>
        ))}
      </List>
    </Box>
  );

  return (
    <>
      <Drawer
        variant="permanent"
        open={open}
        sx={{
          display: { xs: "none", sm: "block" },
          width: open ? DRAWER_WIDTH : MINI_DRAWER_WIDTH,
          flexShrink: 0,
          "& .MuiDrawer-paper": { 
            boxSizing: "border-box", 
            width: open ? DRAWER_WIDTH : MINI_DRAWER_WIDTH,
            backgroundColor: (theme) => theme.palette.background.paper,
            borderRight: (theme) => `1px solid ${theme.palette.divider}`,
            overflowX: "hidden",
            transition: (theme) => theme.transitions.create("width", {
              easing: theme.transitions.easing.sharp,
              duration: theme.transitions.duration.enteringScreen,
            }),
          },
        }}
      >
        {drawer}
      </Drawer>
    </>
  );
}