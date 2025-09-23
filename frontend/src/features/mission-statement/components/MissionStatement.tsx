import Link from "next/link";

import { Button, Box } from "@/components/mui";

export const MissionStatement = () => {
  return (
    <Box
      sx={{
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        height: "100%",
      }}
    >
      {/* ミッションステートメントが既に登録されていれば表示する */}
      <Button variant="contained" color="secondary" sx={{ width: 200 }}>
        <Link
          href="/mission-statement/thinking"
          style={{
            textDecoration: "none",
            color: "inherit",
            fontWeight: "bold",
          }}
        >
          今の自分と向き合う
        </Link>
      </Button>
    </Box>
  );
};
