import { makeColors } from './make-colors.js'

// github.com/rebelot/kanagawa.nvim (MIT): Dragon for dark mode, Lotus for light mode
export const definition: Parameters<typeof makeColors>[0] = {
  label: 'Kanagawa Dragon',
  codeTheme: { dark: 'kanagawa-dragon', light: 'kanagawa-lotus' },
  // top-level roles = dark mode; light overrides in light.roles below
  roles: { accent: '#8ba4b0', danger: '#c4746e', success: '#87a987', warning: '#c4b28a', pro: '#a292a3' },
  dark: {
    gray: {
      anchors: {
        'surface-0': '#181616',
        'surface-1': '#1d1c19',
        'surface-2': '#282727',
        'surface-3': '#393836',
        // dragonWhite is #c5c9c5; nudged a hair lighter so text-primary clears the
        // design system's 4.5:1 check over the (pinned) warning-tinted comment background
        'text-primary': '#d0d4ce',
        'text-secondary': '#b4b8b0',
        'text-muted': '#a6a69c',
      },
    },
    git: { added: '#87a987', removed: '#c4746e', modified: '#c4b28a', merged: '#8992a7', conflicting: '#b6927b' },
  },
  light: {
    roles: { accent: '#4d699b', danger: '#c84053', success: '#6f894e', warning: '#77713f', pro: '#624c83' },
    gray: {
      anchors: {
        'surface-0': '#f2ecbc',
        'surface-1': '#f5f0cc',
        'surface-2': '#f9f4d8',
        'surface-3': '#f9f4d8',
        'text-primary': '#545464',
        'text-secondary': '#5a5a72',
        'text-muted': '#716e61',
      },
    },
    git: { added: '#6f894e', removed: '#c84053', modified: '#77713f', merged: '#624c83', conflicting: '#cc6d00' },
  },
}

export const { theme, problems } = makeColors(definition)
