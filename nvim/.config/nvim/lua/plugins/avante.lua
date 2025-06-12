-- Avante.nvim: Use your Neovim like using Cursor AI IDE
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*" as recommended by the author
  opts = {
    provider = "openai", -- Default provider (you can change to claude, ollama, etc.)
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- You can change this to your preferred model
        extra_request_body = {
          timeout = 30000, -- Timeout in milliseconds
          temperature = 0.75,
          max_completion_tokens = 8192,
        },
      },
      -- You can add other providers here if needed
    },
    -- Set the laststatus option to 3 for global statusline as recommended
    init = function()
      vim.opt.laststatus = 3
    end,
  },
  build = "make", -- This will automatically build the binary
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim", 
    "MunifTanjim/nui.nvim",
    -- Optional dependencies that enhance functionality
    "nvim-telescope/telescope.nvim", -- for file_selector provider
    "nvim-tree/nvim-web-devicons", -- for file icons
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands
    -- Image support
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    -- Markdown rendering
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  -- Add key mappings for Avante
  keys = {
    { "<leader>aa", "<cmd>AvanteToggle<cr>", desc = "Avante: Toggle sidebar" },
    { "<leader>af", "<cmd>AvanteFocus<cr>", desc = "Avante: Switch focus" },
    { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Avante: Refresh" },
    { "<leader>ac", "<cmd>AvanteChat<cr>", desc = "Avante: Start chat" },
    { "<leader>ah", "<cmd>AvanteHistory<cr>", desc = "Avante: Show history" },
    { "<leader>as", "<cmd>AvanteStop<cr>", desc = "Avante: Stop request" },
    { "<leader>am", "<cmd>AvanteModels<cr>", desc = "Avante: Show models" },
  },
}
