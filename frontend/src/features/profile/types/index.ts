export const SexTypes = ["secret", "man", "woman"] as const;
export type SexType = (typeof SexTypes)[number];
