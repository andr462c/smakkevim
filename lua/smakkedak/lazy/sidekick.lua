return {
  "folke/sidekick.nvim",
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = "zellij",
        enabled = true,
      },
      tools = {
        local_qwen_flash = {
          cmd = { "copilot" },
          env = {
            COPILOT_PROVIDER_BASE_URL="http://gpu05:7531/v1",
            COPILOT_MODEL="qwen3.8-flash-next",
            COPILOT_PROVIDER_MAX_OUTPUT_TOKENS = "32768",
            COPILOT_OFFLINE = "true",
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>ant",
      function() require("sidekick").toggle() end,
      desc = "Toggle Next Edit Suggestion",
    },
    {
      "<Tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<C-a>",
      function() require("sidekick.cli").focus() end,
      desc = "Sidekick Focus",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select() end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Select CLI",
    },
    {
      "<leader>ad",
      function() require("sidekick.cli").close() end,
      desc = "Detach a CLI Session",
    },
    {
      "<leader>at",
      function() require("sidekick.cli").send({ msg = "{this}" }) end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function() require("sidekick.cli").send({ msg = "{file}" }) end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function() require("sidekick.cli").send({ msg = "{selection}" }) end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    {
      "<leader>ac",
      function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,
      desc = "Sidekick Toggle Claude",
    },
    {
      "<leader>aq",
      function() require("sidekick.cli").toggle({ name = "local_qwen_flash", focus = true }) end,
      desc = "Sidekick Toggle Local Qwen",
    },
  },
}
