export type User = {
  id: number;
  name: string;
  hasProfile: boolean;
  age: number;
  sex: "secret" | "man" | "woman";
  isPublic: boolean;
};
