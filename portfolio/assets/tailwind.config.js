// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  // Enable dark mode with class strategy
  darkMode: 'class',
  content: [
    "./js/**/*.js",
    "../lib/portfolio_web.ex",
    "../lib/portfolio_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        'primary': 'rgb(211,84,0)',
        'primary-dark': 'rgb(230,126,34)',  // Brighter shade for dark mode
        'secondary': 'rgb(52,152,219)',
        'secondary-dark': 'rgb(41,128,185)',
        brand: "#FD4F00",
      },
      backgroundColor: {
        dark: '#121212',
        'dark-surface': '#1E1E1E',
        'dark-card': '#2D2D2D',
      },
      textColor: {
        'dark-primary': '#E1E1E1',
        'dark-secondary': '#A0A0A0',
      },
      animation: {
        fadeIn: 'fadeIn 0.8s ease-out forwards',
        slideInRight: 'slideInRight 0.5s ease-out forwards',
        slideInLeft: 'slideInLeft 0.5s ease-out forwards',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: 0, transform: 'translateY(10px)' },
          '100%': { opacity: 1, transform: 'translateY(0)' },
        },
        slideInRight: {
          '0%': { opacity: 0, transform: 'translateX(-20px)' },
          '100%': { opacity: 1, transform: 'translateX(0)' },
        },
        slideInLeft: {
          '0%': { opacity: 0, transform: 'translateX(20px)' },
          '100%': { opacity: 1, transform: 'translateX(0)' },
        },
      },
      typography: {
        DEFAULT: {
          css: {
            h1: {
              fontWeight: 700,
            },
            h2: {
              fontWeight: 300,
            },
            a: {
              textDecoration: 'none',
              '&:hover': {
                color: 'rgb(211,84,0)',
              },
            },
          },
        },
        // Dark mode typography variant
        dark: {
          css: {
            color: '#E1E1E1',
            h1: {
              color: '#FFFFFF',
            },
            h2: {
              color: '#FFFFFF',
            },
            h3: {
              color: '#FFFFFF',
            },
            h4: {
              color: '#FFFFFF',
            },
            strong: {
              color: '#FFFFFF',
            },
            a: {
              color: 'rgb(230,126,34)',
              '&:hover': {
                color: 'rgb(243,156,18)',
              },
            },
          },
        },
      },  
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({addVariant}) => addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])),
    plugin(({addVariant}) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({addVariant}) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({addVariant}) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({matchComponents, theme}) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = {name, fullPath: path.join(iconsDir, dir, file)}
        })
      })
      matchComponents({
        "hero": ({name, fullPath}) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, {values})
    })
  ]
}