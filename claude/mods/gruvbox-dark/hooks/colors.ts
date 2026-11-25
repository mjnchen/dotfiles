import { makeColors } from './make-colors.js'

// github.com/morhetz/gruvbox (MIT): Dark Medium for dark mode, Light Medium for light mode
export const definition: Parameters<typeof makeColors>[0] = {
  label: 'Gruvbox Dark',
  codeTheme: { dark: 'gruvbox-dark', light: 'gruvbox-light' },
  // top-level roles = dark mode; light overrides in light.roles below
  roles: { accent: '#83a598', danger: '#fb4934', success: '#b8bb26', warning: '#fabd2f', pro: '#d3869b' },
  dark: {
    gray: {
      anchors: {
        'surface-0': '#1d2021',
        'surface-1': '#282828',
        'surface-2': '#32302f',
        'surface-3': '#3c3836',
        'text-primary': '#ebdbb2',
        'text-secondary': '#d5c4a1',
        'text-muted': '#a89984',
      },
    },
    git: { added: '#b8bb26', removed: '#fb4934', modified: '#fabd2f', merged: '#83a598', conflicting: '#fe8019' },
  },
  light: {
    roles: { accent: '#076678', danger: '#cc241d', success: '#79740e', warning: '#b57614', pro: '#8f3f71' },
    gray: {
      anchors: {
        // light ramp runs darkest (surface-0) to lightest; Gruvbox's base paper
        // (#fbf1c7) is the lightest, so it sits at surface-2/3 and the base is a hair deeper
        'surface-0': '#ebdbb2',
        'surface-1': '#f3e8c0',
        'surface-2': '#fbf1c7',
        'surface-3': '#fbf1c7',
        'text-primary': '#3c3836',
        'text-secondary': '#504945',
        'text-muted': '#665c54',
      },
    },
    git: { added: '#79740e', removed: '#9d0006', modified: '#b57614', merged: '#076678', conflicting: '#af3a03' },
  },
}

export const { theme, problems } = makeColors(definition)
