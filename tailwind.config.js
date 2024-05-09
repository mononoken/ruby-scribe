const colors = require("tailwindcss/colors");

/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  plugins: [require("@tailwindcss/forms"), require("@tailwindcss/typography")],
  theme: {
    extend: {
      colors: {
        mauve: {
          50: "#fbf8fa",
          100: "#f6f0f7",
          200: "#eee0ee",
          300: "#dfc8de",
          400: "#cba7c8",
          500: "#b382b1",
          600: "#93628f",
          700: "#7b5077",
          800: "#654361",
          900: "#553a52",
          950: "#341e32",
        },
        // primary: "#FDFFFC", tailwind: white
        // base: "0E1116", tailwind: neutral-900
        // secondary: stone-400 (gray)
        // alert: #AA4465, tailwind: pink-700
        // active: #822E81, tailwind: fuchsia-800
      },
    },
  },
};
