import { dirname } from "path";
import { fileURLToPath } from "url";
import { FlatCompat } from "@eslint/eslintrc";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const compat = new FlatCompat({
  baseDirectory: __dirname,
});

const eslintConfig = [
  {
    ignores: ["node_modules/**", ".next/**", "out/**", "public/**"]
  },
  ...compat.extends("next/core-web-vitals", "next/typescript"),
  {
    files: ["**/*.{js,jsx,ts,tsx}"],
    plugins: {
      import: (await import("eslint-plugin-import")).default
    },
    rules: {
      "semi": ["error", "always"],
      "quotes": ["error", "double"],
      "indent": ["error", 2],
      "no-unused-vars": ["warn", { 
        "argsIgnorePattern": "^_",
        "varsIgnorePattern": "^_"
      }],
      "no-console": "warn",
      // Import順序とソートのルール
      "import/order": [
        "error",
        {
          "groups": [
            "builtin",    // Node.js組み込みモジュール
            "external",   // 外部ライブラリ
            "internal",   // 内部の絶対パス
            "parent",     // 親ディレクトリからの相対パス
            "sibling",    // 同階層の相対パス
            "index",      // indexファイル
            "type"        // TypeScript type imports
          ],
          "pathGroups": [
            {
              "pattern": "@/**",
              "group": "internal",
              "position": "before"
            }
          ],
          "pathGroupsExcludedImportTypes": ["type"],
          "newlines-between": "always",
          "alphabetize": {
            "order": "asc",
            "caseInsensitive": true
          },
          "distinctGroup": false,
          "warnOnUnassignedImports": true
        }
      ],
      "import/newline-after-import": "error",
      "import/no-duplicates": "error"
    },
    linterOptions: {
      reportUnusedDisableDirectives: true,
      noInlineConfig: false
    }
  }
];

export default eslintConfig;
