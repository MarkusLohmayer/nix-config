local M = {
  "neovim/nvim-lspconfig",
  commit = "649137cbc53a044bffde36294ce3160cb18f32c7",
  lazy = true,
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef",
    },
  },
}

local cmp_nvim_lsp = require "cmp_nvim_lsp"
function M.config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

  local function lsp_keymaps(bufnr)
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true, desc = "Go to declaration" })
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true, desc = "Go to definition" })
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true, desc = "Hover" })
    keymap(
      bufnr,
      "n",
      "gI",
      "<cmd>lua vim.lsp.buf.implementation()<CR>",
      { silent = true, desc = "Go to implementation" }
    )
    keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true, desc = "Go to declaration" })
    keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true, desc = "Show diagnostic" })
    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", { silent = true, desc = "LSP info" })
    keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", { silent = true, desc = "Mason" })
    keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { silent = true, desc = "Code action" })
    keymap(
      bufnr,
      "n",
      "<leader>lj",
      "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>",
      { silent = true, desc = "Next diagnostic" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>lk",
      "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
      { silent = true, desc = "Previous diagnostic" }
    )
    keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { silent = true, desc = "Rename" })
    keymap(
      bufnr,
      "n",
      "<leader>ls",
      "<cmd>lua vim.lsp.buf.signature_help()<CR>",
      { silent = true, desc = "Signature help" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>lq",
      "<cmd>lua vim.diagnostic.setloclist()<CR>",
      { silent = true, desc = "Add diagnostics to location list" }
    )
  end

  local lspconfig = require "lspconfig"
  local on_attach = function(client, bufnr)
    if client.name == "tsserver" then
      client.server_capabilities.documentFormattingProvider = false
    end

    if client.name == "sumneko_lua" then
      client.server_capabilities.documentFormattingProvider = false
    end

    lsp_keymaps(bufnr)
  end

  for _, server in pairs(require("utils").servers) do
    Opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "settings." .. server)
    if require_ok then
      Opts = vim.tbl_deep_extend("force", conf_opts, Opts)
    end

    lspconfig[server].setup(Opts)
  end
end

return M
