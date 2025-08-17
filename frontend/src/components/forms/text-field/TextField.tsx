import { Control, Controller, FieldValues, Path } from "react-hook-form";

import { TextField as MuiTextField } from "@/components/mui";

type Props<T extends FieldValues> = {
  label: string;
  name: Path<T>;
  control: Control<T>;
  // errors: FieldErrors<T>;
}

export const TextField = <T extends FieldValues>({ label, name, control}: Props<T>) => {
  return (
    <Controller
      name={name}
      control={control}
      render={({ field }) => (
        <MuiTextField 
          {...field}
          label={label}
        />
      )}
    />
  );
};