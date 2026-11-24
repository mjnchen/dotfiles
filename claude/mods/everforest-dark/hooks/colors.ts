import { makeColors } from './make-colors.js'

// github.com/sainnhe/everforest (MIT): Dark Medium for dark mode, Light Medium for light mode
export const definition: Parameters<typeof makeColors>[0] = {
  label: 'Everforest Dark',
  codeTheme: { dark: 'everforest-dark', light: 'everforest-light' },
  // top-level roles = dark mode; light overrides in light.roles below
  roles: { accent: '#7fbbb3', danger: '#e67e80', success: '#a7c080', warning: '#dbbc7f', pro: '#d699b6' },
  dark: {
    gray: {
      anchors: {
        'surface-0': '#1e2529',
        'surface-1': '#252c31',
        'surface-2': '#2d353b',
        'surface-3': '#303940',
        // Everforest fg is #d3c6aa; nudged a hair lighter so text-primary clears the
        // design system's 4.5:1 check over the (warning-tinted) active comment background
        'text-primary': '#ddd3bd',
        'text-secondary': '#bdc3b2',
        'text-muted': '#a6b0a0',
      },
    },
    git: { added: '#a7c080', removed: '#e67e80', modified: '#dbbc7f', merged: '#7fbbb3', conflicting: '#e69875' },
  },
  light: {
    roles: { accent: '#3a94c5', danger: '#f85552', success: '#8da101', warning: '#dfa000', pro: '#df69ba' },
    gray: {
      anchors: {
        // light ramp runs darkest (surface-0) to lightest; Everforest's base paper
        // (#fdf6e3) is the lightest, so it sits at surface-2/3 and the base is a hair deeper
        'surface-0': '#efebd4',
        'surface-1': '#f4f0d9',
        'surface-2': '#fdf6e3',
        'surface-3': '#fdf6e3',
        'text-primary': '#5c6a72',
        'text-secondary': '#677a6f',
        'text-muted': '#72817a',
      },
    },
    git: { added: '#8da101', removed: '#f85552', modified: '#dfa000', merged: '#3a94c5', conflicting: '#f57d26' },
  },
}

export const { theme, problems } = makeColors(definition)
