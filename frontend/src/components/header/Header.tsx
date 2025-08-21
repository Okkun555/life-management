import MenuIcon from "@mui/icons-material/Menu";

import { AppBar, IconButton, Toolbar, Typography } from "@/components/mui";

type Props = {
  isOpenSidebar: boolean;
  handleChangeSidebar: (_: boolean) => void;
}

export function Header({ isOpenSidebar, handleChangeSidebar }: Props) {
  return (
    <>
      <AppBar position="fixed" sx={{ displayPrint: "none", zIndex: (theme) => theme.zIndex.drawer + 1 }} color="secondary">
        <Toolbar variant="dense">
          <IconButton
            color="inherit"
            aria-label="open drawer"
            edge="start"
            onClick={() => handleChangeSidebar(isOpenSidebar)}
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