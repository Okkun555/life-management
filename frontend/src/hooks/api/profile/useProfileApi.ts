import useSWRMutation from "swr/mutation";

import { postRequestWithFile } from "@/libs/api/fetcher";
import { path } from "@/libs/api/path";

/**
 * プロフィールの作成
 */
export const useCreateProfile = () => {
  const { trigger, isMutating } = useSWRMutation(path.createProfile, postRequestWithFile, {
    onSuccess: () => {
      console.log("プロフィールキャッシュを再取得");
    },
  });

  return { trigger, isMutating };
};
