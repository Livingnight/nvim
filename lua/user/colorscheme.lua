-- local colorscheme = "darkplus"
-- local colorscheme = "horizon"
-- local colorscheme = "edge"
-- local colorscheme = "tokyonight"
local colorscheme = "aurora"
vim.g.aurora_italic = 1
vim.g.aurora_transparent = 1
vim.g.aurora_bold = 1
vim.g.aurora_darker = 1

-- vim.g.termguicolors = true
-- vim.g.edge_style = "aura"
-- vim.g.edge_better_performance = 1

-- vim.g.onedarker_italic_keywords = false
--
-- vim.g.onedarker_italic_functions = false
--
-- vim.g.onedarker_italic_comments = true
--
-- vim.g.onedarker_italic_loops = false
--
-- vim.g.onedarker_italic_conditionals = false

-- vim.g.tokyodark_transparent_background = false
-- vim.g.tokyodark_enable_italic_comment = true
-- vim.g.tokyodark_enable_italic = true
-- vim.g.tokyodark_color_gamma = "1.0"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  -- vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
