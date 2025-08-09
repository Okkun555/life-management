"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import MDEditor from "@uiw/react-md-editor";
import { useState, useCallback, useEffect } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";



import { Center, Button, Base, ActionDialog, FormControl } from "@/components/elements";
import { api } from "@/libs/api";

import type { CreateMissionStatementPayload, MissionStatementResponse } from "@/types/missionStatement";

const missionSchema = z.object({
  missionStatement: z.string().min(1, "ミッションステートメントを入力してください"),
});

type MissionFormData = z.infer<typeof missionSchema>;

export function MissionStatement() {
  const [isOpen, setIsOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isMounted, setIsMounted] = useState(false);
  
  useEffect(() => {
    setIsMounted(true);
    setIsOpen(false);
  }, []);
  
  const { 
    handleSubmit, 
    formState: { errors }, 
    setValue, 
    watch,
    setError 
  } = useForm<MissionFormData>({
    resolver: zodResolver(missionSchema),
  });

  const handleClick = useCallback(() => setIsOpen(true), []);
  const handleCloseClick = useCallback(() => setIsOpen(false), []);

  const onSubmit = async (data: MissionFormData) => {
    if (isSubmitting) return;

    try {
      setIsSubmitting(true);
      
      const payload: CreateMissionStatementPayload = {
        content: data.missionStatement
      };

      const response = await api.post<CreateMissionStatementPayload, MissionStatementResponse>(
        "/mission_statement",
        { arg: payload }
      );
      console.log("作成成功:", response.data);
      
      handleCloseClick();
    } catch (error) {
      console.error("エラー:", error);
      setError("missionStatement", { 
        type: "submit",
        message: "ミッションステートメントの作成に失敗しました"
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleEditorChange = (value: string | undefined) => {
    setValue("missionStatement", value || "");
  };

  if (!isMounted) {
    return null;
  }

  return (
    <div className="flex flex-col relative min-h-full">
      <Base padding={2}>
        <Center>
          <Button variant="primary" onClick={handleClick} disabled={isSubmitting}>
            ミッションステートメントを作成する
          </Button>
        </Center>
      </Base>

      <ActionDialog
        isOpen={isOpen}
        onClickClose={handleCloseClick}
        title="目標設定"
        actionText={isSubmitting ? "作成中..." : "作成する"}
        onClickAction={() => handleSubmit(onSubmit)()}
        width={"60%"}
      >
        <form>
          <FormControl 
            title="あなたのミッションステートメントを作成しましょう❗️❗️"
            errorMessages={errors.missionStatement?.message}
          >
            <MDEditor
              value={watch("missionStatement")}
              onChange={handleEditorChange}
              height={400}
              preview="edit"
            />
          </FormControl>
        </form>
      </ActionDialog>
    </div>
  );
}