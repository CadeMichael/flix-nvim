-- add `flix` as a filetype
vim.filetype.add({
  extension = {
    flix = "flix",
  }
})

-- flix language defaults
vim.api.nvim_create_autocmd("FileType", {
  pattern = "flix",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.bo.commentstring = "// %s"
  end
})
