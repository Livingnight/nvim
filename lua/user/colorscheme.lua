-- local colorscheme = "onedark"
-- local colorscheme = "darkplus"
-- local colorscheme = "horizon"
local colorscheme = "tokyonight"
-- local colorscheme = "aurora"
-- local colorscheme = "github-theme"
vim.opt.termguicolors = true

-- if colorscheme == "aurora" then
-- vim.opt.aurora_italic = true
-- vim.opt.aurora_transparent = true
-- vim.opt.aurora_bold = true
-- vim.opt.aurora_darker = true
-- end

if colorscheme == "tokyodark" then
  vim.g.tokyodark_transparent_background = false
  vim.g.tokyodark_enable_italic_comment = true
  vim.g.tokyodark_enable_italic = true
  vim.g.tokyodark_color_gamma = "1.0"
end

if colorscheme == "github-theme" then
  -- Example config in Lua
  require("github-theme").setup {
    theme_style = "dark_default", -- dark / dimmed / dark_default / dark_colorblind / light / light_default / light_colorblind
    transparent = true,
  }
end

if colorscheme == "onedark" then
  require("onedark").setup {
    style = "warmer",
  }
  require("onedark").load()
end

if colorscheme == "material" then
  vim.g.material_style = "palenight"
  require("material").setup {

    contrast = {
      terminal = false, -- Enable contrast for the built-in terminal
      sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
      floating_windows = true, -- Enable contrast for floating windows
      cursor_line = false, -- Enable darker background for the cursor line
      non_current_windows = true, -- Enable darker background for non-current windows
      filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
    },

    styles = { -- Give comments style such as bold, italic, underline etc.
      comments = { --[[ italic = true ]]
      },
      strings = { --[[ bold = true ]]
      },
      keywords = { --[[ underline = true ]]
      },
      functions = { --[[ bold = true, undercurl = true ]]
      },
      variables = {},
      operators = {},
      types = {},
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
      -- Available plugins:
      "dap",
      -- "dashboard",
      "gitsigns",
      "hop",
      "indent-blankline",
      -- "lspsaga",
      -- "mini",
      -- "neogit",
      "nvim-cmp",
      "nvim-navic",
      "nvim-tree",
      -- "sneak",
      "telescope",
      -- "trouble",
      "which-key",
    },

    disable = {
      colored_cursor = false, -- Disable the colored cursor
      borders = false, -- Disable borders between verticaly split windows
      background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
      term_colors = false, -- Prevent the theme from setting terminal colors
      eob_lines = false, -- Hide the end-of-buffer lines
    },

    high_visibility = {
      lighter = false, -- Enable higher contrast text for lighter style
      darker = false, -- Enable higher contrast text for darker style
    },

    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_colors = nil, -- If you want to everride the default colors, set this to a function

    custom_highlights = {}, -- Overwrite highlights with your own
  }
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  -- vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

if colorscheme == "tokyonight" then
  require("tokyonight").setup {
    theme = "night", -- storm | moon | night
    -- light_style = "day",
  }
end

-- if colorscheme == "onedark" then
--   -- Lua
--   require("onedark").setup {
-- 	  style = 'darker'
--   }
--   require("onedark").load()
-- end
