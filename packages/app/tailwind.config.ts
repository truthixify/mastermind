import type { Config } from "tailwindcss";

const config: Config = {
  darkMode: ["class"],
  content: ["./src/**/*.{js,ts,jsx,tsx,mdx}", "./public/index.html"],
  theme: {
    extend: {
      colors: {
        // Retro/cartoon color palette
        "retro-red": "#FF5252",
        "retro-blue": "#29ADFF",
        "retro-yellow": "#FFD600",
        "retro-green": "#4CAF50",
        "retro-purple": "#B388FF",
        "retro-orange": "#FF9800",
        "retro-cyan": "#18FFFF",

        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
        retro: "1rem",
      },
      boxShadow: {
        // Cartoon-like shadows
        cartoon: "0 8px 0 0 rgba(0, 0, 0, 0.2)",
        "cartoon-sm": "0 4px 0 0 rgba(0, 0, 0, 0.2)",
        "cartoon-button": "0 6px 0 0 #2D2D2D",
        "cartoon-button-hover": "0 4px 0 0 #2D2D2D",
        "cartoon-button-active": "0 2px 0 0 #2D2D2D",
        "cartoon-inner": "inset 0 4px 0 0 rgba(0, 0, 0, 0.1)",
      },
      dropShadow: {
        "cartoon-text": "2px 2px 0 rgba(0, 0, 0, 0.3)",
        "cartoon-text-lg": "3px 3px 0 rgba(0, 0, 0, 0.3)",
      },
      borderWidth: {
        cartoon: "4px",
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
        pop: "pop 0.3s ease-out",
      },
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
        pop: {
          "0%": { transform: "scale(0.8)", opacity: "0" },
          "50%": { transform: "scale(1.1)" },
          "100%": { transform: "scale(1)", opacity: "1" },
        },
      },
    },
  },
  plugins: [require("tailwindcss-animate"), require("daisyui")],
  daisyui: {
    themes: [
      {
        retroCartoon: {
          primary: "#FF5252", // retro-red
          secondary: "#29ADFF", // retro-blue
          accent: "#FFD600", // retro-yellow
          neutral: "#3D3D3D",
          "base-100": "#F8F9FA",
          info: "#18FFFF", // retro-cyan
          success: "#4CAF50", // retro-green
          warning: "#FF9800", // retro-orange
          error: "#FF5252", // retro-red
        },
        retroCartoonDark: {
          primary: "#FF5252", // retro-red
          secondary: "#29ADFF", // retro-blue
          accent: "#FFD600", // retro-yellow
          neutral: "#2D2D2D",
          "base-100": "#3D3D3D",
          info: "#18FFFF", // retro-cyan
          success: "#4CAF50", // retro-green
          warning: "#FF9800", // retro-orange
          error: "#FF5252", // retro-red
        },
      },
    ],
    darkTheme: "retroCartoonDark",
    base: true,
    styled: true,
    utils: true,
    logs: false,
    rtl: false,
    prefix: "",
  },
};

export default config;
