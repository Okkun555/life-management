export type Profile = {
  name: string;
  age: number;
  sex: SexType;
};

export const SexTypes = {
  secret: "secret",
  man: "man",
  woman: "woman",
} as const;
export type SexType = keyof typeof SexTypes;
