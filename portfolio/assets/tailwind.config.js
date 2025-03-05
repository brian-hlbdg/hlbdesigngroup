// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/portfolio_web.ex",
    "../lib/portfolio_web/**/*.*ex"
  ],
  darkMode: 'class', // Enable class-based dark mode
  theme: {
    extend: {
      colors: {
        'primary': 'rgb(211,84,0)',
        'primary-dark': 'rgb(180,70,0)',
        brand: "#FD4F00",
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
        // Add dark mode typography
        dark: {
          css: {
            color: 'rgb(229, 231, 235)',
            '[class~="lead"]': {
              color: 'rgb(209, 213, 219)',
            },
            a: {
              color: 'rgb(229, 231, 235)',
              '&:hover': {
                color: 'rgb(211,84,0)',
              },
            },
            strong: {
              color: 'rgb(249, 250, 251)',
            },
            'ol > li::before': {
              color: 'rgb(156, 163, 175)',
            },
            'ul > li::before': {
              backgroundColor: 'rgb(107, 114, 128)',
            },
            hr: {
              borderColor: 'rgb(75, 85, 99)',
            },
            blockquote: {
              color: 'rgb(209, 213, 219)',
              borderLeftColor: 'rgb(75, 85, 99)',
            },
            h1: {
              color: 'rgb(249, 250, 251)',
            },
            h2: {
              color: 'rgb(249, 250, 251)',
            },
            h3: {
              color: 'rgb(249, 250, 251)',
            },
            h4: {
              color: 'rgb(249, 250, 251)',
            },
            'figure figcaption': {
              color: 'rgb(156, 163, 175)',
            },
            code: {
              color: 'rgb(249, 250, 251)',
            },
            'a code': {
              color: 'rgb(249, 250, 251)',
            },
            pre: {
              color: 'rgb(229, 231, 235)',
              backgroundColor: 'rgb(31, 41, 55)',
            },
            thead: {
              color: 'rgb(249, 250, 251)',
              borderBottomColor: 'rgb(75, 85, 99)',
            },
            'tbody tr': {
              borderBottomColor: 'rgb(55, 65, 81)',
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

    // Add dark mode variant
    plugin(({addVariant}) => addVariant("dark", [".dark &", ".dark&"])),

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