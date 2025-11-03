import useSWR from "swr";

import { fetcher } from "@/libs/api/fetcher";
import { path } from "@/libs/api/path";

import type { User } from "./types";

/**
 * ユーザー情報の取得
 */
export const useFetchMe = () => {
  const { data, isLoading } = useSWR<User>(path.me, fetcher);

  return {
    me: data,
    isLoading,
  };
};
