-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
--  See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  When connected over SSH, leave clipboard unset so OSC 52 can handle
--  clipboard sync through the terminal emulator instead.
--  See `:help 'clipboard'` and `:help clipboard-osc52`
vim.schedule(function() vim.o.clipboard = vim.env.SSH_CONNECTION and '' or 'unnamedplus' end)

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Use spaces instead of tabs when pressing Tab or auto-indenting.
--  See `:help 'expandtab'`, `:help 'shiftwidth'`, `:help 'tabstop'`
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- ============================================================================
-- [[ Additional options inspired by LazyVim ]]
-- ============================================================================

-- Control how the completion menu behaves.
-- See `:help 'completeopt'`
vim.o.completeopt = 'menu,menuone,noselect'

-- Enable 24-bit RGB colors in the terminal (required for modern colorschemes).
-- See `:help 'termguicolors'`
vim.o.termguicolors = true

-- Automatically write modified buffers before certain actions (e.g. `:make`).
-- See `:help 'autowrite'`
vim.o.autowrite = true

-- Configure automatic formatting behavior when typing (e.g. comment wrapping).
-- See `:help 'formatoptions'`
vim.o.formatoptions = 'jcroqlnt'

-- Use ripgrep for `:grep` with a vim-friendly output format.
-- See `:help 'grepprg'` and `:help 'grepformat'`
vim.o.grepprg = 'rg --vimgrep'
vim.o.grepformat = '%f:%l:%c:%m'

-- Command-line completion mode: complete longest common prefix first, then
-- show full matches on subsequent presses.
-- See `:help 'wildmode'`
vim.o.wildmode = 'longest:full,full'

-- Suppress certain verbose messages (written, intro screen, completion, etc.).
-- See `:help 'shortmess'`
vim.opt.shortmess:append { W = true, I = true, c = true, C = true }

-- Automatically insert indents in a smart way based on the current language.
-- See `:help 'smartindent'`
vim.o.smartindent = true

-- Round indentation to a multiple of 'shiftwidth' when shifting lines.
-- See `:help 'shiftround'`
vim.o.shiftround = true

-- Allow the cursor to move past the end of a line in visual block mode.
-- See `:help 'virtualedit'`
vim.o.virtualedit = 'block'

-- Disable soft line wrapping (lines will extend beyond the window width).
-- See `:help 'wrap'`
vim.o.wrap = false

-- Hide certain markup characters (e.g. * / _ in markdown) when not on the line.
-- See `:help 'conceallevel'`
vim.o.conceallevel = 2

-- Slight transparency for the popup menu and cap its height.
-- See `:help 'pumblend'` and `:help 'pumheight'`
vim.o.pumblend = 10
vim.o.pumheight = 10

-- Number of undo levels to keep (much deeper than the default).
-- See `:help 'undolevels'`
vim.o.undolevels = 10000

-- Enable smooth scrolling (Neovim 0.10+).
-- See `:help 'smoothscroll'`
vim.o.smoothscroll = true

-- Minimum number of screen columns to keep left/right of the cursor.
-- See `:help 'sidescrolloff'`
vim.o.sidescrolloff = 8

-- Start with all folds open so they don't collapse by default.
-- See `:help 'foldlevel'`, `:help 'foldmethod'`, and `:help 'foldtext'`
vim.o.foldlevel = 99
vim.o.foldmethod = 'indent'
vim.o.foldtext = ''

-- Minimum window width when splitting.
-- See `:help 'winminwidth'`
vim.o.winminwidth = 5

-- Keep the screen as stable as possible when opening/closing splits.
-- See `:help 'splitkeep'`
vim.o.splitkeep = 'screen'

-- Default language for spell checking.
-- See `:help 'spelllang'`
vim.o.spelllang = 'en'

-- vim: ts=2 sts=2 sw=2 et
