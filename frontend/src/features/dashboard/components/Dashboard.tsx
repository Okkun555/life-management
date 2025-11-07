"use client";

import { useRouter } from "next/navigation";
import { useEffect } from "react";

import { useFetchMe } from "@/hooks/api/common/useMe";

export const Dashboard = () => {
  const router = useRouter();
  // TODO: useFetchMeはヘッダー等で呼び出し→グローバルステートに保管。その値を見た方がいいかも
  const { me } = useFetchMe();

  useEffect(() => {
    if (me && !me.hasProfile) {
      router.push("/profile/register");
    }
  }, [me, router]);

  return (
    <>
      <div>ダッシュボード</div>
    </>
  );
};
