import { makeColors } from './make-colors.js'

// github.com/folke/tokyonight.nvim (Apache-2.0): Storm for dark mode, Day for light mode
export const definition: Parameters<typeof makeColors>[0] = {
  label: 'Tokyo Night Storm',
  codeTheme: { dark: 'tokyo-night', light: 'github-light' },
  // top-level roles = dark mode; light overrides in light.roles below
  roles: { accent: '#7aa2f7', danger: '#f7768e', success: '#9ece6a', warning: '#e0af68', pro: '#bb9af7' },
  dark: {
    gray: {
      anchors: {
        'surface-0': '#1a1b26',
        'surface-1': '#1f2335',
        'surface-2': '#24283b',
        'surface-3': '#292e42',
        'text-primary': '#c0caf5',
        'text-secondary': '#a9b1d6',
        'text-muted': '#8a93c2',
      },
    },
    git: { added: '#9ece6a', removed: '#f7768e', modified: '#e0af68', merged: '#7aa2f7', conflicting: '#ff9e64' },
  },
  light: {
    roles: { accent: '#2e7de9', danger: '#f52a65', success: '#587539', warning: '#8c6c3e', pro: '#9854f1' },
    gray: {
      anchors: {
        // light ramp runs darkest (surface-0) to lightest; Tokyo Night Day's base
        // (#e1e2e7) is the lightest, so it sits at surface-2/3 and the base is a hair deeper
        'surface-0': '#d0d5e3',
        'surface-1': '#dadce5',
        'surface-2': '#e1e2e7',
        'surface-3': '#e1e2e7',
        'text-primary': '#2e4a86',
        'text-secondary': '#45588f',
        'text-muted': '#59629a',
      },
    },
    git: { added: '#587539', removed: '#f52a65', modified: '#8c6c3e', merged: '#2e7de9', conflicting: '#b15c00' },
  },
}

export const { theme, problems } = makeColors(definition)
