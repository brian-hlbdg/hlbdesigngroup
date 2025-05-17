// tailwind.config.js
module.exports = {
    // Tell Tailwind where to look for classes to include in the build
    content: [
      "./src/**/*.{html,js}",
      "./*.html",
      "./js/**/*.js",
      "./components/**/*.{html,js}",
      // Add any other file paths where you use Tailwind classes
    ],
    
    // Enable class-based dark mode
    darkMode: 'class',
    
    theme: {
      extend: {
        // Custom colors
        colors: {
          'primary': 'rgb(211,84,0)',
          'primary-dark': 'rgb(180,70,0)',
          'brand': '#FD4F00', // Alternative brand color from your Phoenix app
        },
        
        // Custom fonts
        fontFamily: {
          'sans': ['Inter', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'Helvetica Neue', 'Arial', 'sans-serif'],
        },
        
        // Custom animations
        animation: {
          'fade-in': 'fadeIn 0.8s ease-out forwards',
          'slide-up': 'slideUp 0.8s ease-out forwards',
          'slide-in-right': 'slideInRight 0.5s ease-out forwards',
          'slide-in-left': 'slideInLeft 0.5s ease-out forwards',
        },
        
        // Custom keyframes
        keyframes: {
          fadeIn: {
            '0%': { opacity: '0', transform: 'translateY(10px)' },
            '100%': { opacity: '1', transform: 'translateY(0)' },
          },
          slideUp: {
            '0%': { transform: 'translateY(20px)', opacity: '0' },
            '100%': { transform: 'translateY(0)', opacity: '1' },
          },
          slideInRight: {
            '0%': { opacity: '0', transform: 'translateX(-20px)' },
            '100%': { opacity: '1', transform: 'translateX(0)' },
          },
          slideInLeft: {
            '0%': { opacity: '0', transform: 'translateX(20px)' },
            '100%': { opacity: '1', transform: 'translateX(0)' },
          },
        },
        
        // Custom spacing (if needed)
        spacing: {
          '18': '4.5rem',
          '88': '22rem',
        },
        
        // Custom screen sizes (if needed)
        screens: {
          'xs': '475px',
          '3xl': '1600px',
        },
        
        // Custom typography (if using @tailwindcss/typography)
        typography: {
          DEFAULT: {
            css: {
              maxWidth: 'none',
              color: 'rgb(55, 65, 81)', // text-gray-700
              '[class~="lead"]': {
                color: 'rgb(75, 85, 99)', // text-gray-600
              },
              a: {
                color: 'rgb(211, 84, 0)', // primary color
                textDecoration: 'none',
                fontWeight: '500',
                '&:hover': {
                  color: 'rgb(180, 70, 0)', // primary-dark
                },
              },
              h1: {
                fontWeight: '700',
                color: 'rgb(17, 24, 39)', // text-gray-900
              },
              h2: {
                fontWeight: '600',
                color: 'rgb(17, 24, 39)', // text-gray-900
              },
              h3: {
                fontWeight: '600',
                color: 'rgb(17, 24, 39)', // text-gray-900
              },
            },
          },
          // Dark mode typography
          dark: {
            css: {
              color: 'rgb(229, 231, 235)', // text-gray-200
              '[class~="lead"]': {
                color: 'rgb(209, 213, 219)', // text-gray-300
              },
              a: {
                color: 'rgb(211, 84, 0)', // primary color stays same in dark
                '&:hover': {
                  color: 'rgb(180, 70, 0)', // primary-dark
                },
              },
              h1: {
                color: 'rgb(248, 250, 252)', // text-slate-50
              },
              h2: {
                color: 'rgb(248, 250, 252)', // text-slate-50
              },
              h3: {
                color: 'rgb(248, 250, 252)', // text-slate-50
              },
              strong: {
                color: 'rgb(248, 250, 252)', // text-slate-50
              },
              code: {
                color: 'rgb(248, 250, 252)', // text-slate-50
              },
              blockquote: {
                color: 'rgb(209, 213, 219)', // text-gray-300
                borderLeftColor: 'rgb(75, 85, 99)', // border-gray-600
              },
            },
          },
        },
      },
    },
    
    // Add Tailwind plugins
    plugins: [
      // Typography plugin (install with: npm install @tailwindcss/typography)
      require('@tailwindcss/typography'),
      
      // Forms plugin (install with: npm install @tailwindcss/forms)
      require('@tailwindcss/forms'),
      
      // Line-clamp plugin (install with: npm install @tailwindcss/line-clamp)
      require('@tailwindcss/line-clamp'),
      
      // Custom plugin for additional utilities
      function({ addUtilities, theme, addVariant }) {
        // Add custom utilities if needed
        addUtilities({
          '.scrollbar-none': {
            'scrollbar-width': 'none', /* Firefox */
            '&::-webkit-scrollbar': {
              display: 'none' /* Safari and Chrome */
            }
          },
          '.perspective-1000': {
            perspective: '1000px',
          },
          '.preserve-3d': {
            'transform-style': 'preserve-3d',
          },
        });
        
        // Add custom variants if needed
        addVariant('not-first', '&:not(:first-child)');
        addVariant('not-last', '&:not(:last-child)');
      },
    ],
  };