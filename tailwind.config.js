/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ['class'],
  content: [
    './pages/**/*.{ts,tsx}',
    './components/**/*.{ts,tsx}',
    './app/**/*.{ts,tsx}',
    './src/**/*.{ts,tsx}',
    './lib/**/*.{ts,tsx}',
    './hooks/**/*.{ts,tsx}',
    './utils/**/*.{ts,tsx}',
    './types/**/*.{ts,tsx}',
  ],
  prefix: '',
  theme: {
    container: {
      center: true,
      padding: '2rem',
      screens: {
        '2xl': '1400px',
      },
    },
    extend: {
      colors: {
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        ring: 'hsl(var(--ring))',
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        primary: {
          DEFAULT: 'hsl(var(--primary))',
          foreground: 'hsl(var(--primary-foreground))',
        },
        secondary: {
          DEFAULT: 'hsl(var(--secondary))',
          foreground: 'hsl(var(--secondary-foreground))',
        },
        destructive: {
          DEFAULT: 'hsl(var(--destructive))',
          foreground: 'hsl(var(--destructive-foreground))',
        },
        muted: {
          DEFAULT: 'hsl(var(--muted))',
          foreground: 'hsl(var(--muted-foreground))',
        },
        accent: {
          DEFAULT: 'hsl(var(--accent))',
          foreground: 'hsl(var(--accent-foreground))',
        },
        popover: {
          DEFAULT: 'hsl(var(--popover))',
          foreground: 'hsl(var(--popover-foreground))',
        },
        card: {
          DEFAULT: 'hsl(var(--card))',
          foreground: 'hsl(var(--card-foreground))',
        },
        // Quantum theme colors
        quantum: {
          50: '#f0f9ff',
          100: '#e0f2fe',
          200: '#bae6fd',
          300: '#7dd3fc',
          400: '#38bdf8',
          500: '#0ea5e9',
          600: '#0284c7',
          700: '#0369a1',
          800: '#075985',
          900: '#0c4a6e',
          950: '#082f49',
        },
        // DeFi theme colors
        defi: {
          50: '#fefce8',
          100: '#fef9c3',
          200: '#fef08a',
          300: '#fde047',
          400: '#facc15',
          500: '#eab308',
          600: '#ca8a04',
          700: '#a16207',
          800: '#854d0e',
          900: '#713f12',
          950: '#422006',
        },
        // Security theme colors
        security: {
          50: '#f0fdf4',
          100: '#dcfce7',
          200: '#bbf7d0',
          300: '#86efac',
          400: '#4ade80',
          500: '#22c55e',
          600: '#16a34a',
          700: '#15803d',
          800: '#166534',
          900: '#14532d',
          950: '#052e16',
        },
        // Error theme colors
        error: {
          50: '#fef2f2',
          100: '#fee2e2',
          200: '#fecaca',
          300: '#fca5a5',
          400: '#f87171',
          500: '#ef4444',
          600: '#dc2626',
          700: '#b91c1c',
          800: '#991b1b',
          900: '#7f1d1d',
          950: '#450a0a',
        },
        // Warning theme colors
        warning: {
          50: '#fffbeb',
          100: '#fef3c7',
          200: '#fde68a',
          300: '#fcd34d',
          400: '#fbbf24',
          500: '#f59e0b',
          600: '#d97706',
          700: '#b45309',
          800: '#92400e',
          900: '#78350f',
          950: '#451a03',
        },
      },
      borderRadius: {
        lg: 'var(--radius)',
        md: 'calc(var(--radius) - 2px)',
        sm: 'calc(var(--radius) - 4px)',
      },
      fontFamily: {
        sans: ['var(--font-geist-sans)', 'system-ui', 'sans-serif'],
        mono: ['var(--font-geist-mono)', 'monospace'],
        quantum: ['var(--font-quantum)', 'monospace'],
      },
      keyframes: {
        'accordion-down': {
          from: { height: '0' },
          to: { height: 'var(--radix-accordion-content-height)' },
        },
        'accordion-up': {
          from: { height: 'var(--radix-accordion-content-height)' },
          to: { height: '0' },
        },
        'fade-in': {
          '0%': { opacity: '0', transform: 'translateY(10px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
        'fade-out': {
          '0%': { opacity: '1', transform: 'translateY(0)' },
          '100%': { opacity: '0', transform: 'translateY(-10px)' },
        },
        'slide-in': {
          '0%': { transform: 'translateX(-100%)' },
          '100%': { transform: 'translateX(0)' },
        },
        'slide-out': {
          '0%': { transform: 'translateX(0)' },
          '100%': { transform: 'translateX(-100%)' },
        },
        'scale-in': {
          '0%': { transform: 'scale(0.95)', opacity: '0' },
          '100%': { transform: 'scale(1)', opacity: '1' },
        },
        'scale-out': {
          '0%': { transform: 'scale(1)', opacity: '1' },
          '100%': { transform: 'scale(0.95)', opacity: '0' },
        },
        'rotate-in': {
          '0%': { transform: 'rotate(-180deg)', opacity: '0' },
          '100%': { transform: 'rotate(0)', opacity: '1' },
        },
        'rotate-out': {
          '0%': { transform: 'rotate(0)', opacity: '1' },
          '100%': { transform: 'rotate(-180deg)', opacity: '0' },
        },
        'quantum-pulse': {
          '0%': { transform: 'scale(1)', opacity: '1' },
          '50%': { transform: 'scale(1.05)', opacity: '0.8' },
          '100%': { transform: 'scale(1)', opacity: '1' },
        },
        'quantum-glow': {
          '0%': { boxShadow: '0 0 0 0 rgba(14, 165, 233, 0.7)' },
          '70%': { boxShadow: '0 0 0 10px rgba(14, 165, 233, 0)' },
          '100%': { boxShadow: '0 0 0 0 rgba(14, 165, 233, 0)' },
        },
        'security-scan': {
          '0%': { transform: 'translateY(-100%)', opacity: '0' },
          '50%': { transform: 'translateY(0)', opacity: '1' },
          '100%': { transform: 'translateY(-100%)', opacity: '0' },
        },
        'defi-pulse': {
          '0%': { transform: 'scale(1)', backgroundColor: 'rgba(234, 179, 8, 0.2)' },
          '50%': { transform: 'scale(1.05)', backgroundColor: 'rgba(234, 179, 8, 0.4)' },
          '100%': { transform: 'scale(1)', backgroundColor: 'rgba(234, 179, 8, 0.2)' },
        },
      },
      animation: {
        'accordion-down': 'accordion-down 0.2s ease-out',
        'accordion-up': 'accordion-up 0.2s ease-out',
        'fade-in': 'fade-in 0.3s ease-out',
        'fade-out': 'fade-out 0.3s ease-out',
        'slide-in': 'slide-in 0.3s ease-out',
        'slide-out': 'slide-out 0.3s ease-out',
        'scale-in': 'scale-in 0.2s ease-out',
        'scale-out': 'scale-out 0.2s ease-out',
        'rotate-in': 'rotate-in 0.3s ease-out',
        'rotate-out': 'rotate-out 0.3s ease-out',
        'quantum-pulse': 'quantum-pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'quantum-glow': 'quantum-glow 2s cubic-bezier(0.4, 0, 0.6, 1) infinite',
        'security-scan': 'security-scan 2s linear infinite',
        'defi-pulse': 'defi-pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite',
      },
      spacing: {
        '18': '4.5rem',
        '88': '22rem',
        '128': '32rem',
        '144': '36rem',
      },
      fontSize: {
        '2xs': ['0.625rem', { lineHeight: '0.75rem' }],
        '3xs': ['0.5625rem', { lineHeight: '0.6875rem' }],
        '4xs': ['0.5rem', { lineHeight: '0.625rem' }],
        '5xs': ['0.4375rem', { lineHeight: '0.5625rem' }],
      },
      lineHeight: {
        '3': '1.5rem',
        '4': '2rem',
        '5': '2.5rem',
        '6': '3rem',
        '7': '3.5rem',
        '8': '4rem',
        '9': '4.5rem',
        '10': '5rem',
      },
      letterSpacing: {
        'tighter': '-0.05em',
        'tight': '-0.025em',
        'normal': '0em',
        'wide': '0.025em',
        'wider': '0.05em',
        'widest': '0.1em',
      },
      maxWidth: {
        '8xl': '88rem',
        '9xl': '96rem',
        '10xl': '128rem',
      },
      minHeight: {
        '128': '32rem',
        '144': '36rem',
        '160': '40rem',
        '176': '44rem',
        '192': '48rem',
      },
      minWidth: {
        '128': '32rem',
        '144': '36rem',
        '160': '40rem',
        '176': '44rem',
        '192': '48rem',
      },
      height: {
        '128': '32rem',
        '144': '36rem',
        '160': '40rem',
        '176': '44rem',
        '192': '48rem',
      },
      width: {
        '128': '32rem',
        '144': '36rem',
        '160': '40rem',
        '176': '44rem',
        '192': '48rem',
      },
      screens: {
        'xs': '475px',
        '3xl': '1600px',
        '4xl': '1920px',
      },
      backdropBlur: {
        xs: '2px',
      },
      zIndex: {
        '60': '60',
        '70': '70',
        '80': '80',
        '90': '90',
        '100': '100',
      },
    },
  },
  plugins: [
    require('tailwindcss-animate'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/container-queries'),
    require('@tailwindcss/line-clamp'),
    require('@tailwindcss/scrollbar'),
    // Custom plugin for quantum theme
    function({ addUtilities, theme }) {
      const newUtilities = {
        '.text-gradient': {
          background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
          '-webkit-background-clip': 'text',
          '-webkit-text-fill-color': 'transparent',
          'background-clip': 'text',
        },
        '.bg-quantum': {
          background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
        },
        '.bg-defi': {
          background: 'linear-gradient(135deg, #f59e0b 0%, #d97706 100%)',
        },
        '.bg-security': {
          background: 'linear-gradient(135deg, #22c55e 0%, #16a34a 100%)',
        },
        '.bg-error': {
          background: 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)',
        },
        '.bg-warning': {
          background: 'linear-gradient(135deg, #f59e0b 0%, #d97706 100%)',
        },
        '.text-quantum': {
          color: theme('colors.quantum.500'),
        },
        '.text-defi': {
          color: theme('colors.defi.500'),
        },
        '.text-security': {
          color: theme('colors.security.500'),
        },
        '.text-error': {
          color: theme('colors.error.500'),
        },
        '.text-warning': {
          color: theme('colors.warning.500'),
        },
        '.border-quantum': {
          borderColor: theme('colors.quantum.500'),
        },
        '.border-defi': {
          borderColor: theme('colors.defi.500'),
        },
        '.border-security': {
          borderColor: theme('colors.security.500'),
        },
        '.border-error': {
          borderColor: theme('colors.error.500'),
        },
        '.border-warning': {
          borderColor: theme('colors.warning.500'),
        },
        '.shadow-quantum': {
          boxShadow: '0 0 20px rgba(14, 165, 233, 0.5)',
        },
        '.shadow-defi': {
          boxShadow: '0 0 20px rgba(234, 179, 8, 0.5)',
        },
        '.shadow-security': {
          boxShadow: '0 0 20px rgba(34, 197, 94, 0.5)',
        },
        '.shadow-error': {
          boxShadow: '0 0 20px rgba(239, 68, 68, 0.5)',
        },
        '.shadow-warning': {
          boxShadow: '0 0 20px rgba(245, 158, 11, 0.5)',
        },
        '.hover-scale': {
          transition: 'transform 0.2s ease',
        },
        '.hover-scale:hover': {
          transform: 'scale(1.05)',
        },
        '.hover-glow': {
          transition: 'box-shadow 0.2s ease',
        },
        '.hover-glow:hover': {
          boxShadow: '0 0 30px rgba(14, 165, 233, 0.8)',
        },
        '.glass': {
          backgroundColor: 'rgba(255, 255, 255, 0.1)',
          backdropFilter: 'blur(10px)',
          border: '1px solid rgba(255, 255, 255, 0.2)',
        },
        '.glass-dark': {
          backgroundColor: 'rgba(0, 0, 0, 0.1)',
          backdropFilter: 'blur(10px)',
          border: '1px solid rgba(255, 255, 255, 0.1)',
        },
        '.neon': {
          textShadow: '0 0 10px currentColor',
        },
        '.neon-border': {
          boxShadow: '0 0 10px currentColor, inset 0 0 10px currentColor',
        },
      };
      addUtilities(newUtilities);
    },
  ],
};
