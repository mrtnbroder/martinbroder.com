/** @type {import('prettier').Options} */
export default {
  $schema: "http://json.schemastore.org/prettierrc",
  arrowParens: "always",
  bracketSameLine: true,
  bracketSpacing: true,
  htmlWhitespaceSensitivity: "ignore",
  printWidth: 80,
  proseWrap: "never",
  quoteProps: "consistent",
  semi: false,
  tabWidth: 2,
  trailingComma: "all",
  plugins: [
    "prettier-plugin-svelte",
    "prettier-plugin-tailwindcss",
  ],
  tailwindPreserveWhitespace: false,
  tailwindPreserveDuplicates: false,
  pluginSearchDirs: false,
  svelteAllowShorthand: false,
  svelteIndentScriptAndStyle: true,
  svelteSortOrder: "options-scripts-markup-styles",
  svelteStrictMode: false,
  overrides: [
    {
      files: "*.svelte",
      options: { parser: "svelte" },
    },
  ],
}
