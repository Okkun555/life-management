import axios from "axios";

const axiosInstance = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL,
});

const headers = new Headers({
  "Content-Type": "application/json",
});

export const fetcher = (url: string) => axiosInstance.get(url, { headers });

export const postRequest = (url: string, { arg }: { arg: unknown }) => {
  return axiosInstance.post(url, arg);
};

export const putRequest = (url: string, { arg }: { arg: unknown }) => {
  return axiosInstance.put(url, arg);
};

export const deleteRequest = (url: string) => axiosInstance.delete(url);
