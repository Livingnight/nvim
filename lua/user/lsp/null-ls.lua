local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity

-- setting up null_ls formatting key commands
local nullls_lsp_keymaps = function(bufnr)
  local opts = { noremap = true, silent = true }
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<c-f>", "<cmd>Format<cr>", opts)
end

-- disabling lsp server formatting / making null_ls the only formatting option
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format {
    timeout_ms = 2000,
    filter = function(client)
      --apply whatever logic you want(in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  }
end

-- creating Augroup LspFormatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- setting up formatting on save autocommand
local function setupFormatOnSave(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

null_ls.setup {
  on_attach = function(client, bufnr)
    nullls_lsp_keymaps(bufnr)
    setupFormatOnSave(client, bufnr)
    lsp_formatting(bufnr)
  end,
  debug = true,
  sources = {
    formatting.prettierd.with {
      extra_filetypes = { "telekasten" },
      env = {
        PRETTIERD_DEFAULT_CONFIG = vim.fn.expand "~/.config/linter-config/.prettierrc.json",
      },
    },
    -- python
    formatting.black.with { extra_args = { "--fast" } },
    -- lua
    formatting.stylua,
    -- bash script
    formatting.shfmt,
    -- java among other things
    formatting.clang_format,
    -- diagnostics.flake8,
    diagnostics.shellcheck,
  },
}

local unwrap = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "rust" },
  generator = {
    fn = function(params)
      local diagnostics = {}
      -- sources have access to a params object
      -- containing info about the current file and editor state
      for i, line in ipairs(params.content) do
        local col, end_col = line:find "unwrap()"
        if col and end_col then
          -- null-ls fills in undefined positions
          -- and converts source diagnostics into the required format
          table.insert(diagnostics, {
            row = i,
            col = col,
            end_col = end_col,
            source = "unwrap",
            message = "hey " .. os.getenv "USER" .. ", don't forget to handle this",
            severity = 2,
          })
        end
      end
      return diagnostics
    end,
  },
}

null_ls.register(unwrap)
