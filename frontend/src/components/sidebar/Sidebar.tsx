import AccessibilityIcon from "@mui/icons-material/Accessibility";
import CalendarMonthIcon from "@mui/icons-material/CalendarMonth";
import CalendarViewMonthIcon from "@mui/icons-material/CalendarViewMonth";
import ListAltIcon from "@mui/icons-material/ListAlt";
import Link from "next/link";
import { usePathname } from "next/navigation";

import { 
  Box, 
  Drawer, 
  List, 
  ListItem, 
  ListItemButton, 
  ListItemIcon, 
  Toolbar,
  Typography
} from "@/components/mui";

const menuItems = [
  {
    text: "Mission Statement",
    icon: <AccessibilityIcon />,
    href: "/mission-statement"
  },
  {
    text: "年間目標",
    icon: <CalendarViewMonthIcon />,
    href: "/yearly-goal"
  },
  {
    text: "月間目標",
    icon: <CalendarMonthIcon />,
    href: "/monthly-goal"
  },
  {
    text: "TODO管理",
    icon: <ListAltIcon />,
    href: "/todo-list"
  }
];

export function Sidebar() {
  const pathname = usePathname();

  return (
    <Drawer variant="permanent" open={true} sx={{ width: "64px" }}>
      <Box>
        <Toolbar sx={{ displayPrint: "none" }} />
        <List>
          {menuItems.map(item => (
            <ListItem key={item.href} sx={{ mb: 2 }}>
              <ListItemButton  component={Link} href={item.href} selected={pathname === item.href}>
                <ListItemIcon sx={{
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center"
                }}>{item.icon}</ListItemIcon>
                <Typography sx={{
                  position: "absolute",
                  bottom: -12,
                  left: "50%",
                  transform: "translateX(-50%)",
                  fontSize: 10,
                  fontWeight: 500,
                  textAlign: "center",
                  whiteSpace: "nowrap",
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                }}>{item.text}</Typography>
              </ListItemButton>
            </ListItem>
          ))}
        </List>
      </Box>
    </Drawer>
  );
}