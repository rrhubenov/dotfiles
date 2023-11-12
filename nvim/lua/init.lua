vim.lsp.start({
  name = 'c++',
  cmd = {'clangd'},
  root_dir = vim.fs.dirname(vim.fs.find({'Makefile', 'CMakeLists.txt'}, { upward = true })[1]),
})
