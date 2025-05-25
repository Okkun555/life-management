// APIの基本設定
// FIXME: 環境変数で設定できるようにしたい
const API_BASE_URL = "http://localhost:4000/api";

// CSRFトークンの取得
const getCsrfToken = () => {
  if (typeof document === "undefined") return "";
  
  return document.querySelector<HTMLMetaElement>("meta[name=\"csrf-token\"]")?.content || "";
};

// 共通のヘッダー設定
const getHeaders = () => {
  return {
    "Content-Type": "application/json",
    "X-CSRF-Token": getCsrfToken(),
  };
};

// エラーハンドリング用のヘルパー関数
const handleApiError = (error: unknown): never => {
  if (error instanceof Response) {
    throw new Error(`APIエラー: ${error.status}`);
  }
  throw error;
};

// CRUD操作用の関数群
export const api = {
  get: async <T>(url: string): Promise<T> => {
    try {
      const response = await fetch(`${API_BASE_URL}${url}`, {
        headers: getHeaders(),
      });
      if (!response.ok) throw response;
      return response.json();
    } catch (error) {
      throw handleApiError(error);
    }
  },
  post: async <TData, TResponse>(
    url: string, 
    { arg }: { arg: TData }
  ): Promise<TResponse> => {
    try {
      const response = await fetch(`${API_BASE_URL}${url}`, {
        method: "POST",
        headers: getHeaders(),
        body: JSON.stringify(arg)
      });
      if (!response.ok) throw response;
      return response.json();
    } catch (error) {
      throw handleApiError(error);
    }
  },
  put: async <TData, TResponse>(
    url: string, 
    { arg }: { arg: TData }
  ): Promise<TResponse> => {
    try {
      const response = await fetch(`${API_BASE_URL}${url}`, {
        method: "PUT",
        headers: getHeaders(),
        body: JSON.stringify(arg)
      });
      if (!response.ok) throw response;
      return response.json();
    } catch (error) {
      throw handleApiError(error);
    }
  },
  delete: async <TResponse>(url: string): Promise<TResponse> => {
    try {
      const response = await fetch(`${API_BASE_URL}${url}`, {
        method: "DELETE",
        headers: getHeaders(),
      });
      if (!response.ok) throw response;
      return response.json();
    } catch (error) {
      throw handleApiError(error);
    }
  }
};
