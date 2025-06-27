local M = {}

function M.set_config()
  require("lspconfig.configs").flix = {
    default_config = {
      cmd = { "java", "-jar", "flix.jar", "lsp" },
      filetypes = { "flix" },
      root_dir = function(fname)
        local root_dir = vim.fs.dirname(vim.fs.find({ "flix.toml", "flix.jar" }, { path = fname, upward = true })[1])
            or vim.fs.dirname(fname)
        local flix_jar_path = vim.fs.joinpath(root_dir, "flix.jar")
        if vim.loop.fs_stat(flix_jar_path) == nil then
          print("Failed to start the LSP server: flix.jar not found in project root (" .. root_dir .. ")!\n")
          return nil
        end
        return root_dir
      end,
      settings = {},
    },
  }
end

function M.flix_lsp(c, a)
  require("lspconfig").flix.setup {
    capabilities = c,
    on_attach = function(_, bufnr)
      -- flix specific pre attatch actions
      print("Flix LSP attached to buffer " .. bufnr)
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        pattern = "<buffer>",
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = bufnr })
        end,
      })
      a(_, bufnr)
    end,
  }
end

return M
