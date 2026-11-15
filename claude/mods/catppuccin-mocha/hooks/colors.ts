import { makeColors } from './make-colors.js'

// catppuccin/palette (MIT): Mocha for dark mode, Latte for light mode
export const definition: Parameters<typeof makeColors>[0] = {
  label: 'Catppuccin Mocha',
  codeTheme: { dark: 'catppuccin-mocha', light: 'catppuccin-latte' },
  roles: { accent: '#89b4fa', danger: '#f38ba8', success: '#a6e3a1', warning: '#f9e2af', pro: '#cba6f7' },
  dark: {
    gray: {
      anchors: {
        'surface-0': '#181825',
        'surface-1': '#1e1e2e',
        'surface-2': '#222233',
        'surface-3': '#252536',
        'text-primary': '#cdd6f4',
        'text-secondary': '#bac2de',
        'text-muted': '#a6adc8',
      },
    },
    git: { added: '#a6e3a1', removed: '#f38ba8', modified: '#f9e2af', merged: '#cba6f7', conflicting: '#fab387' },
  },
  light: {
    roles: { accent: '#1e66f5', danger: '#d20f39', success: '#40a02b', warning: '#df8e1d', pro: '#8839ef' },
    gray: {
      anchors: {
        'surface-0': '#e6e9ef',
        'surface-1': '#eff1f5',
        'surface-2': '#f5f6f9',
        'surface-3': '#f5f6f9',
        'text-primary': '#4c4f69',
        'text-secondary': '#5c5f77',
        'text-muted': '#6c6f85',
      },
    },
    git: { added: '#40a02b', removed: '#d20f39', modified: '#df8e1d', merged: '#8839ef', conflicting: '#fe640b' },
  },
}

export const { theme, problems } = makeColors(definition)
