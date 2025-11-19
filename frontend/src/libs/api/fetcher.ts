import axios from "axios";
import { camelizeKeys } from "humps";

const axiosInstance = axios.create({
  baseURL: process.env.NEXT_PUBLIC_API_URL,
  headers: {
    "Content-Type": "application/json",
    Accept: "application/json",
    "X-Dev-User-UID":
      process.env.NODE_ENV === "development" ? process.env.NEXT_PUBLIC_DEV_USER_UID : undefined, // 開発環境用のログインIDを添付
  },
});

export const fetcher = <T>(url: string): Promise<T> =>
  // MEMO: API側からはスネークケースでレスポンスが返ってくるので、camelizeKeysでデータをキャメルケースに変換
  axiosInstance.get(url).then((res) => camelizeKeys(res.data) as T);

export const postRequest = <U, T>(url: string, { arg }: { arg: U }): Promise<T> =>
  axiosInstance.post(url, arg).then((res) => camelizeKeys(res.data) as T);

export const putRequest = <U, T>(url: string, { arg }: { arg: U }): Promise<T> =>
  axiosInstance.put(url, arg).then((res) => camelizeKeys(res.data) as T);

export const deleteRequest = <T>(url: string): Promise<T> =>
  axiosInstance.delete(url).then((res) => camelizeKeys(res.data) as T);

/** ファイルアップロード系 */
export const postRequestWithFile = <U, T>(url: string, { arg }: { arg: U }): Promise<T> => {
  const formData = appendFormData(arg);
  return axiosInstance
    .post(url, formData, {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    })
    .then((res) => camelizeKeys(res.data) as T);
};

// eslint-disable-next-line
const appendFormData = (data: any, parentKey = ""): FormData => {
  const formData = new FormData();

  // eslint-disable-next-line
  const addToFormData = (obj: any, prefix = "") => {
    Object.keys(obj).forEach((key) => {
      const value = obj[key];
      const formKey = prefix ? `${prefix}[${key}]` : key;

      if (value instanceof File) {
        formData.append(formKey, value);
      } else if (typeof value === "object" && value !== null) {
        addToFormData(value, formKey);
      } else if (value !== null && value !== undefined) {
        formData.append(formKey, String(value));
      }
    });
  };

  addToFormData(data, parentKey);
  return formData;
};
