/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  // plugins: [
  //   require('@tailwindcss/forms'),
  //   require('@tailwindcss/aspect-ratio'),
  //   require('@tailwindcss/typography'),
  //   require('@tailwindcss/container-queries'),
  // ]
};