import postcssImport from "postcss-import";
import tailwindcssNesting from "tailwindcss/nesting";
import tailwind from "tailwindcss";
import tailwindConfig from "./tailwind.config.js";
import autoprefixer from "autoprefixer";

export default {
  plugins: [
    postcssImport,
    tailwindcssNesting,
    tailwind(tailwindConfig),
    autoprefixer,
  ],
};
