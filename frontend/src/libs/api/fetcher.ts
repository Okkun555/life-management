import axios from "axios";

const axiosInstance = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL,
  headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "X-Dev-User-UID": process.env.NODE_ENV === "development" ? process.env.NEXT_PUBLIC_DEV_USER_UID : undefined, // 開発環境用のログインIDを添付
  }
});

export const fetcher = <T>(url: string): Promise<T> => axiosInstance.get(url).then(res => res.data);

export const postRequest = <T, U>(url: string, { arg }: { arg: U }): Promise<T> => axiosInstance.post(url, arg).then(res => res.data);

export const putRequest = <T, U>(url: string, { arg }: { arg: U }): Promise<T> => axiosInstance.put(url, arg).then(res => res.data);

export const deleteRequest = <T>(url: string): Promise<T> => axiosInstance.delete(url).then(res => res.data);

