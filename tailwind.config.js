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
        purplehaze: "#93628f",
        // primary: "#FDFFFC", tailwind: white
        // base: "0E1116", tailwind: neutral-900
        // secondary: stone-400 (gray)
        // alert: #AA4465, tailwind: pink-700
        // active: #822E81, tailwind: fuchsia-800
        //
        // abandon? dark purple: "#9E7B9B", tailwind: none closest is stone-400 (gray)
        // abandon? mauve: "#CB9CF2", tailwind: violet-300
        // abandon? lightning yellow: "#FABC2A", tailwind: amber-400
      },
    },
  },
};
