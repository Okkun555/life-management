"use client";

import { Center, Button, Base, ActionDialog } from "@/components/elements";
import { useState, useCallback } from "react";

export function MissionStatement() {
  const [isOpen, setIsOpen] = useState(true);

  const handleClick = useCallback(() => setIsOpen(true), []);
  const handleCloseClick = useCallback(() => setIsOpen(false), []);

  return (
    <div className="flex flex-col relative min-h-full">
      <Base padding={2} >
        <Center>
          <Button variant="primary" onClick={handleClick}>
                ミッションステートメントを作成する
          </Button>
        </Center>
      </Base>

      <ActionDialog
        isOpen={isOpen}
        onClickClose={handleCloseClick}
        title="あなたのMissionStatement"
        actionText="作成する"
        onClickAction={() => console.log("作成")}
      >
        AAA
      </ActionDialog>
    </div>
  );
}