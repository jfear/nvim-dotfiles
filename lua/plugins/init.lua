-- Auto-load all plugin config files under lua/plugins/ (excluding init.lua)
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'plugins')

---@param dir string
---@param prefix string
local function load_plugins(dir, prefix)
  for file_name, type in vim.fs.dir(dir, { follow = true }) do
    local path = vim.fs.joinpath(dir, file_name)
    if type == 'directory' then
      load_plugins(path, prefix .. file_name .. '.')
    elseif (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
      local module = prefix .. file_name:gsub('%.lua$', '')
      require(module)
    end
  end
end

load_plugins(plugins_dir, 'plugins.')

-- vim: ts=2 sts=2 sw=2 et
