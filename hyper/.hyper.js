"use strict";

module.exports = {
  config: {
    updateChannel: "stable",

    // --- Appearance ---
    fontSize: 16,
    fontFamily: '"FiraCode Nerd Font", "FiraCode NF", Menlo, monospace',
    fontWeight: "normal",
    fontWeightBold: "bold",
    lineHeight: 1.1,
    letterSpacing: 0,

    cursorColor: "rgba(0,255,140,0.9)",
    cursorAccentColor: "#000",
    cursorShape: "BEAM",
    cursorBlink: true,

    foregroundColor: "#00ff66",
    backgroundColor: "rgba(0, 0, 0, 0.10)",
    selectionColor: "rgba(0, 255, 102, 0.25)",
    borderColor: "#003300",

    padding: "12px 18px",

    // --- MATRIX DARK GREEN CSS + Glow ---
    css: `
      .hyper_main {
        background: rgba(0, 12, 0, 0.40) !important;
        backdrop-filter: blur(16px) brightness(0.9) contrast(1.1);
        box-shadow:
          0 0 25px #00ff6688,
          0 0 45px #00cc5588,
          inset 0 0 25px #00ff6633,
          inset 0 0 40px #00cc5522;
        border-radius: 10px;
        animation: matrixFlicker 3s infinite ease-in-out;
      }

      .terms_terms {
        background: transparent !important;
      }

      .terminal {
        text-shadow: 0 0 6px #00ff66aa;
      }

      @keyframes matrixFlicker {
        0%   { opacity: 0.98; }
        50%  { opacity: 0.94; }
        100% { opacity: 0.98; }
      }
    `,

    termCSS: "",

    // --- Shell / Startup ---
    shell: "C:\\\\Program Files\\\\PowerShell\\\\7\\\\pwsh.exe",
    shellArgs: ["-NoLogo"],

    workingDirectory: "C:\\\\Users\\\\thomas.appelt",
    preserveCWD: false,

    copyOnSelect: true,
    quickEdit: true,
    webGLRenderer: true,
    disableLigatures: false,
    disableAutoUpdates: false,
    screenReaderMode: false,
    defaultSSHApp: true,
  },

  // --- Plugins (NO hyperpower anymore) ---
  plugins: [
  "hyper-snazzy",
  "hyper-statusline",
  "hyper-tabs-enhanced",
  "hyper-search"
],

  localPlugins: [],

  // --- tmux-like Pane Navigation ---
  keymaps: {
    "pane:prev": "alt+h",
    "pane:next": "alt+l",
    "pane:up": "alt+k",
    "pane:down": "alt+j"
  },
};