import { makeColors } from './make-colors.js'

// draculatheme.com/spec (MIT): Dracula for dark mode, Alucard for light mode
export const definition: Parameters<typeof makeColors>[0] = {
  label: 'Dracula',
  // No Alucard code theme exists in the app; one-light is the closest light pick
  codeTheme: { dark: 'dracula', light: 'one-light' },
  roles: { accent: '#bd93f9', danger: '#ff5555', success: '#50fa7b', warning: '#f1fa8c', pro: '#ff79c6' },
  dark: {
    gray: {
      anchors: {
        'surface-0': '#21222c',
        'surface-1': '#282a36',
        'surface-2': '#2c2e3b',
        'surface-3': '#303241',
        'text-primary': '#f8f8f2',
        'text-secondary': '#e0e0da',
        'text-muted': '#a3a8c4',
      },
    },
    git: { added: '#50fa7b', removed: '#ff5555', modified: '#f1fa8c', merged: '#bd93f9', conflicting: '#ffb86c' },
  },
  light: {
    roles: { accent: '#644ac9', danger: '#cb3a2a', success: '#14710a', warning: '#846e15', pro: '#a3144d' },
    gray: {
      anchors: {
        'surface-0': '#f5f0dc',
        'surface-1': '#fffbeb',
        'surface-2': '#fffdf4',
        'surface-3': '#fffdf4',
        'text-primary': '#1f1f1f',
        'text-secondary': '#3a382f',
        'text-muted': '#6c664b',
      },
    },
    git: { added: '#14710a', removed: '#cb3a2a', modified: '#846e15', merged: '#644ac9', conflicting: '#a34d14' },
  },
}

export const { theme, problems } = makeColors(definition)
