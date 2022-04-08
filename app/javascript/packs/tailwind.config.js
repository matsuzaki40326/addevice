module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/**/*.html.slim',
    './app/helpers/**/*.rb',
    './app/javascript/packs/**/*.js',
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    screens: {
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
    },
    extend: {
      colors: {
        cyan: '#9cdbff',
        pur1: '#a485e3'
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/line-clamp'),
  ],
}
