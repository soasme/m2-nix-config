{ pkgs }:
{
  enable = true;
  viAlias = true;
  vimAlias = true;
  withPython3 = true;
  extraPackages = with pkgs; [
    gcc
    nixfmt-classic
    black
    nodejs
    nodePackages.prettier
  ];
  plugins = with pkgs.vimPlugins; [
    lazy-nvim
  ];
  extraConfig = ''
    lua <<EOF

    -- set rno
    vim.wo.relativenumber = true

    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
      local lazyrepo = "https://github.com/folke/lazy.nvim.git"
      local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
      if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
          { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
          { out, "WarningMsg" },
          { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
      end
    end
    vim.opt.rtp:prepend(lazypath)
    
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"
    
    require("lazy").setup({
      install = { colorscheme = { "habamax" } },
      checker = { enabled = true },
      spec = {
        { "tpope/vim-fugitive" },
        { "tpope/vim-commentary" },
        { "junegunn/fzf.vim" },
        { "nvim-lualine/lualine.nvim" },
        { "github/copilot.vim" },
        { "dracula/vim", name = "dracula" },
        { "LnL7/vim-nix" },
        {
          "ggandor/leap.nvim",
          config = function()
            require('leap').create_default_mappings()
          end,
        },
        {
          "sbdchd/neoformat",
          config = function()
            vim.g.neoformat_enabled_nix = {"nixfmt"}
            vim.g.neoformat_enabled_python = {"black"}
          end,
        },
        {
          "yetone/avante.nvim",
          event = "VeryLazy",
          lazy = false,
          version = false,
          opts = {
            provider = "claude", -- Recommend using Claude
            auto_suggestions_provider = "copilot", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
            claude = {
              endpoint = "https://api.anthropic.com",
              model = "claude-3-5-sonnet-20240620",
              temperature = 0,
              max_tokens = 4096,
            },
            behaviour = {
              auto_suggestions = true, -- Experimental stage
              auto_set_highlight_group = true,
              auto_set_keymaps = true,
              auto_apply_diff_after_generation = false,
              support_paste_from_clipboard = false,
            },
            mappings = {
              --- @class AvanteConflictMappings
              diff = {
                ours = "co",
                theirs = "ct",
                all_theirs = "ca",
                both = "cb",
                cursor = "cc",
                next = "]x",
                prev = "[x",
              },
              suggestion = {
                accept = "<M-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
              },
              jump = {
                next = "]]",
                prev = "[[",
              },
              submit = {
                normal = "<CR>",
                insert = "<C-s>",
              },
              sidebar = {
                apply_all = "A",
                apply_cursor = "a",
                switch_windows = "<Tab>",
                reverse_switch_windows = "<S-Tab>",
              },
            },
            hints = { enabled = true },
            windows = {
              ---@type "right" | "left" | "top" | "bottom"
              position = "right", -- the position of the sidebar
              wrap = true, -- similar to vim.o.wrap
              width = 30, -- default % based on available width
              sidebar_header = {
                align = "center", -- left, center, right for title
                rounded = true,
              },
              input = {
                prefix = "> ",
              },
              edit = {
                border = "rounded",
                start_insert = true, -- Start insert mode when opening the edit window
              },
              ask = {
                floating = false, -- Open the 'AvanteAsk' prompt in a floating window
                start_insert = true, -- Start insert mode when opening the ask window, only effective if floating = true.
                border = "rounded",
              },
            },
            highlights = {
              ---@type AvanteConflictHighlights
              diff = {
                current = "DiffText",
                incoming = "DiffAdd",
              },
            },
            --- @class AvanteConflictUserConfig
            diff = {
              autojump = true,
              ---@type string | fun(): any
              list_opener = "copen",
            },
          },
          build = "make",
          dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            "zbirenbaum/copilot.lua",
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
            {
              'MeanderingProgrammer/render-markdown.nvim',
              opts = {
                file_types = { "markdown", "Avante" },
              },
              ft = { "markdown", "Avante" },
            },
          },
        }
      },
    })
    EOF
  '';
}
