import MenuIcon from "@mui/icons-material/Menu";

import { AppBar, IconButton, Toolbar, Typography } from "@/components/mui";

type Props = {
  onMenuClick: () => void;
}

export function Header({ onMenuClick }: Props) {
  return (
    <>
      <AppBar position="fixed" sx={{ displayPrint: "none", zIndex: (theme) => theme.zIndex.drawer + 1 }} color="secondary">
        <Toolbar variant="dense">
          <IconButton
            color="inherit"
            aria-label="open drawer"
            edge="start"
            onClick={onMenuClick}
            sx={{ mr: 2 }}
          >
            <MenuIcon />
          </IconButton>
          <Typography variant="h6">Life Management</Typography>
        </Toolbar>
      </AppBar>
    </>
  );
}