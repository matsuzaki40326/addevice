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
      'xs': '320px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
    },
    extend: {
      colors: {
        twi: '#15202b',
        twibg: '#273340',
        pur1: '#a485e3',
        teal300: '#81e6d9',
        teal400: '#4fd1c5',
        orange500: '#ed8936',
        ratyyellow: '#ffb251',
        cream1: '#fbf8ef',
        cream2: '#f7f1e0',
        cream3: '#f8f4e6'
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/line-clamp'),
  ],
}
