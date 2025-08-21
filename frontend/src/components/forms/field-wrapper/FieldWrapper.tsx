import { Box, FormControl, Typography } from "@/components/mui"
import { PropsWithChildren } from "react"

type FieldWrapperProps = PropsWithChildren<{
  label: string
  required?: boolean
  errorMessage?: string
}>

export type FieldWrapperPassThroughProps = Omit<FieldWrapperProps, 'children'>

export const FieldWrapper = ({ label, required, errorMessage, children }: FieldWrapperProps) => {
  return (
    <FormControl fullWidth error={!!errorMessage}>
      <Box sx={{ display: 'flex', flexDirection: 'column', gap: 0.5 }}>
        <Box sx={{ display: 'flex', gap: 0.5 }}>
          <Typography sx={{ fontSize: 14 }}>{label}</Typography>
          {required && (
            <Typography color="error" fontSize={12}>
              ※必須
            </Typography>
          )}
        </Box>
        {children}
        {errorMessage && (
          <Typography color="error" fontSize={12}>
            {errorMessage}
          </Typography>
        )}
      </Box>
    </FormControl>
  )
}