"use client";

import { useRouter } from "next/navigation";
import { useEffect } from "react";

import { useFetchMe } from "@/hooks/api/common/useMe";

export const Dashboard = () => {
  const router = useRouter();
  /**
   * TODO:要検討
   * meの値はグローバルステート保管した方がいいかも
   * ヘッダ等でmeを叩いてグルーバルステートに格納、各コンポーネントではそれを見るとか？
   */
  const { me } = useFetchMe();

  useEffect(() => {
    if (me && !me.hasProfile) {
      router.push("/profile/register");
    }
  }, [me, router]);

  return (
    <>
      <div>このページはダッシュボード画面です。様々な情報を今後追加予定です。</div>
    </>
  );
};
