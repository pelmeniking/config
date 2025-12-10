"use strict";
// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    updateChannel: "stable",

    // Font
    fontSize: 16,
    fontFamily: '"FiraCode Nerd Font", "FiraCode NF", "Fira Code", Menlo, monospace',
    fontWeight: "normal",
    fontWeightBold: "bold",
    lineHeight: 1,
    letterSpacing: 0,

    // Cursor
    cursorColor: "rgba(0,255,140,0.9)",
    cursorAccentColor: "#000",
    cursorShape: "BEAM",
    cursorBlink: true,

    // Colors / Background
    foregroundColor: "#ffffff",
    backgroundColor: "rgba(0,0,0,0.85)",
    selectionColor: "rgba(248,28,229,0.3)",
    borderColor: "#333",

    // Custom CSS
    css: "",
    termCSS: "",

    // Startup dir
    workingDirectory: "",

    showHamburgerMenu: "",
    showWindowControls: "",

    // Padding
    padding: "12px 18px",

    // Base color palette (wird von Theme-Plugin überschrieben, ist aber okay)
    colors: {
      black: "#000000",
      red: "#C51E14",
      green: "#1DC121",
      yellow: "#C7C329",
      blue: "#0A2FC4",
      magenta: "#C839C5",
      cyan: "#20C5C6",
      white: "#C7C7C7",
      lightBlack: "#686868",
      lightRed: "#FD6F6B",
      lightGreen: "#67F86F",
      lightYellow: "#FFFA72",
      lightBlue: "#6A76FB",
      lightMagenta: "#FD7CFC",
      lightCyan: "#68FDFE",
      lightWhite: "#FFFFFF",
      limeGreen: "#32CD32",
      lightCoral: "#F08080",
    },

    // Shell = pwsh 7
    shell: "C:\\Program Files\\PowerShell\\7\\pwsh.exe",
    shellArgs: ["-NoLogo"],

    env: {},

    bell: "SOUND",
    // bellSoundURL: '/path/to/sound/file',

    copyOnSelect: false,
    defaultSSHApp: true,
    quickEdit: true,

    macOptionSelectionMode: "vertical",
    webGLRenderer: true,
    webLinksActivationKey: "",
    disableLigatures: true,
    disableAutoUpdates: false,
    screenReaderMode: false,
    preserveCWD: true,
  },

  // 🔥 Plugins – Neon + Utility + Fun
  plugins: [
    // Theme / Style
    "hyper-snazzy",         // Neon-Theme

    // Utility
    "hypercwd",             // neue Tabs/Splits im gleichen Ordner
    "hyper-search",         // Ctrl+Shift+F – Suche im Terminal
    "hyper-tabs-enhanced",  // bessere Tabs
    "hyper-statusline",     // Statusleiste unten
    "hyper-pane",           // bessere Split-Navigation

    // Fun
    "hyperpower"            // Partikel beim Tippen 😈
  ],

  localPlugins: [],

  keymaps: {
    // 'window:devtools': 'cmd+alt+o',
  },
};

//# sourceMappingURL=config-default.js.map
