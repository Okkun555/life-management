import { LocalizationProvider } from "@mui/x-date-pickers";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { jaJP } from "@mui/x-date-pickers/locales";
import "dayjs/locale/ja";
import { Control, FieldValues, Path } from "react-hook-form";
import { DatePickerElement, DatePickerElementProps } from "react-hook-form-mui/date-pickers";

type DatePickerProps<T extends FieldValues> = {
  name: Path<T>;
  label: DatePickerElementProps["label"];
  control: Control<T>;
};

export const DatePicker = <T extends FieldValues>({ name, label, control }: DatePickerProps<T>) => (
  <LocalizationProvider
    dateAdapter={AdapterDayjs}
    adapterLocale="ja"
    localeText={jaJP.components.MuiLocalizationProvider.defaultProps.localeText}
  >
    <DatePickerElement name={name} label={label} control={control} />
  </LocalizationProvider>
);
