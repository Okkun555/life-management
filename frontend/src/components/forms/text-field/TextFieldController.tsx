import { FieldPathByValue, FieldValues, UseFormRegisterReturn } from "react-hook-form";

import { TextField, TextFieldProps } from "./TextField";

type TextFieldControllerProps<TFieldValues extends FieldValues> = {
  registration: UseFormRegisterReturn<FieldPathByValue<TFieldValues, string>>
  textField: TextFieldProps
}

/*
MEMO:
RHFとViewコンポーネントのつなぎこみを行う
コンポーネント側ではこのControllerを呼び出して利用する

参考：
- https://github.com/KazukiHayase/RHF-MUI-sample
- https://zenn.dev/buyselltech/articles/51da30508f9687
*/
export const TextFieldController = <TFieldValues extends FieldValues>({
  registration,
  textField: { fieldWrapper, ...muiTextField },
}: TextFieldControllerProps<TFieldValues>) => {
  return (
    <TextField
      fieldWrapper={fieldWrapper}
      muiTextField={{
        ...muiTextField,
        ...registration,
      }}
    />
  );
};