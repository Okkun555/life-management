import Image from "next/image";
import { useState } from "react";
import { Control, Controller, FieldValues, Path } from "react-hook-form";

import { Box, Button, Typography } from "@/components/mui-material";

type FileUploadProps<T extends FieldValues> = {
  name: Path<T>;
  label: string;
  control: Control<T>;
  accept?: string;
  multiple?: boolean;
};

export const FileUpload = <T extends FieldValues>({
  name,
  label,
  control,
  accept,
  multiple,
}: FileUploadProps<T>) => {
  const [preview, setPreview] = useState<string | null>(null);

  return (
    <Controller
      name={name}
      control={control}
      render={({ field: { onChange }, fieldState: { error } }) => (
        <Box>
          <Typography variant="body2" sx={{ mb: 1 }}>
            {label}
          </Typography>
          <Button variant="outlined" component="label" sx={{ mb: 2 }}>
            ファイルを選択
            <input
              type="file"
              hidden
              accept={accept}
              multiple={multiple}
              onChange={(e) => {
                const file = e.target.files?.[0];
                if (file) {
                  onChange(file);
                  // プレビュー用のURLを作成
                  const reader = new FileReader();
                  reader.onload = () => {
                    setPreview(reader.result as string);
                  };
                  reader.readAsDataURL(file);
                } else {
                  onChange(null);
                  setPreview(null);
                }
              }}
            />
          </Button>
          {preview && (
            <Box sx={{ mt: 2 }}>
              <Image
                src={preview}
                alt="プレビュー"
                width={200}
                height={200}
                style={{
                  maxWidth: "200px",
                  maxHeight: "200px",
                  objectFit: "cover",
                  borderRadius: "8px",
                }}
              />
            </Box>
          )}

          {error && (
            <Typography color="error" variant="caption" display="block">
              {error.message}
            </Typography>
          )}
        </Box>
      )}
    />
  );
};
