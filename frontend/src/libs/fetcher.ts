import axios from "axios";

const axiosInstance = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL,
  headers: {
    "Content-Type": "application/json",
    "X-Dev-User-UID": process.env.NODE_ENV === "development" ? process.env.NEXT_PUBLIC_DEV_USER_UID : undefined, // 開発環境用のログインIDを添付
  }
});


export const fetcher = <T>(url: string): Promise<T> => axiosInstance.get(url);

export const postRequest = (url: string, { arg }: { arg: unknown }) => {
  return axiosInstance.post(url, arg);
};

export const putRequest = (url: string, { arg }: { arg: unknown }) => {
  return axiosInstance.put(url, arg);
};

export const deleteRequest = (url: string) => axiosInstance.delete(url);
