import { Box, LinearProgress, Typography } from "@/components/mui";

type TodoProgressBarProps = {
  value: number;
};

export const TodoProgressBar = ({ value }: TodoProgressBarProps) => {
  return (
    <Box sx={{ display: "flex", alignItems: "center" }}>
      <Box sx={{ width: "100%", mr: 1 }}>
        <LinearProgress variant="determinate" value={value} color="secondary" />
      </Box>
      <Box>
        <Typography variant="body2" color="text.secondary">
          {value}%
        </Typography>
      </Box>
    </Box>
  );
};
