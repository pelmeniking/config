"use strict";

module.exports = {
  config: {
    updateChannel: "stable",

    fontSize: 16,
    fontFamily: '"FiraCode Nerd Font", "FiraCode NF", Menlo, monospace',

    cursorColor: "rgba(0,255,200,0.9)",
    cursorShape: "BEAM",
    cursorBlink: true,

    foregroundColor: "#00ffc8",
    backgroundColor: "rgba(0, 0, 0, 0.10)",
    selectionColor: "rgba(0, 255, 200, 0.25)",

    borderColor: "#002630",

    padding: "12px 18px",

    css: `
      .hyper_main {
        background: rgba(0, 12, 20, 0.35) !important;
        backdrop-filter: blur(16px) brightness(1) contrast(1.05);

        /* Subtiler Cyan Glow */
        box-shadow:
          0 0 12px #00eaff55,
          0 0 22px #00eaff33;

        border-radius: 10px;
        animation: matrixFlicker 3s infinite ease-in-out;
      }

      .terms_terms {
        background: transparent !important;
      }

      .terminal {
        text-shadow: 0 0 6px #00ffcc88;
      }

      @keyframes matrixFlicker {
        0%   { opacity: 0.98; }
        50%  { opacity: 0.94; }
        100% { opacity: 0.98; }
      }
    `,

    shell: "C:\\\\Program Files\\\\PowerShell\\\\7\\\\pwsh.exe",
    shellArgs: ["-NoLogo"],

    workingDirectory: "C:\\\\Users\\\\thomas.appelt",
    preserveCWD: false,

    copyOnSelect: true,
    quickEdit: true,
    webGLRenderer: true,
    disableLigatures: false,
  },

  plugins: [
    "hyper-snazzy",
    "hyper-statusline",
    "hyper-tabs-enhanced",
    "hyper-search"
  ],

  keymaps: {
    "pane:prev": "alt+h",
    "pane:next": "alt+l",
    "pane:up": "alt+k",
    "pane:down": "alt+j"
  },
};
