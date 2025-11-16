import { TextFieldProps as MuiTextFieldProps } from "@mui/material";

import { FieldWrapper } from "@/components/forms/field-wrapper";
import { TextField as MuiTextField } from "@/components/mui";

import type { FieldWrapperPassThroughProps } from "@/components/forms/field-wrapper/FieldWrapper";

export type TextFieldProps = {
  fieldWrapper: FieldWrapperPassThroughProps;
  muiTextField?: MuiTextFieldProps;
};

/*
MEMO:
見た目にのみ関心を持つViewコンポーネント
Storybookはこのコンポーネントに対してのみ実装する
*/
export const TextField = ({ fieldWrapper, muiTextField }: TextFieldProps) => {
  return (
    <FieldWrapper {...fieldWrapper}>
      <MuiTextField {...muiTextField} error={!!fieldWrapper.errorMessage} />
    </FieldWrapper>
  );
};
