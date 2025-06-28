-- add `flix` as a filetype
vim.filetype.add({
  extension = {
    flix = "flix",
  }
})

-- flix language defaults
local flix = vim.api.nvim_create_augroup("flix", { clear = true })
local flix_lsp = vim.api.nvim_create_augroup("flix", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = flix,
  pattern = "flix",
  callback = function(args)
    vim.api.nvim_clear_autocmds({group = flix_lsp})
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.bo.commentstring = "// %s"
    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      group = flix_lsp,
      pattern = "<buffer>",
      callback = function()
        vim.lsp.codelens.refresh({ bufnr = args.buf })
      end
    })
  end
})
