-- Enable faster startup by caching compiled Lua modules.
-- See `:help vim.loader.enable()`
vim.loader.enable()

-- ============================================================================
-- Leader key (must be set before plugins are loaded)
-- ============================================================================
-- Set <space> as the leader key.
-- See `:help mapleader` and `:help maplocalleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Global variables
-- ============================================================================
-- Set to true if you have a Nerd Font installed and selected in the terminal.
-- Used by plugins to decide whether to show icons.
vim.g.have_nerd_font = true

-- ============================================================================
-- UI / Display
-- ============================================================================
-- Show line numbers. See `:help 'number'`
vim.o.number = true

-- Show relative line numbers. See `:help 'relativenumber'`
vim.o.relativenumber = true

-- Enable 24-bit RGB colors in the terminal (required for modern colorschemes).
-- See `:help 'termguicolors'`
vim.o.termguicolors = true

-- Enable mouse mode (clicking, scrolling, resizing splits).
-- See `:help 'mouse'`
vim.o.mouse = "a"

-- Don't show the mode since it's already in the status line.
-- See `:help 'showmode'`
vim.o.showmode = false

-- Always show the sign column (gitsigns, diagnostics, etc.) to prevent text
-- from jumping when signs appear or disappear.
-- See `:help 'signcolumn'`
vim.o.signcolumn = "yes"

-- Highlight the line where the cursor is.
-- See `:help 'cursorline'`
vim.o.cursorline = true

-- Preview substitutions live, as you type.
-- See `:help 'inccommand'`
vim.o.inccommand = "split"

-- Display certain whitespace characters in the editor.
-- See `:help 'list'` and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Hide certain markup characters (e.g. * / _ in markdown) when not on the line.
-- See `:help 'conceallevel'`
vim.o.conceallevel = 2

-- Slight transparency for the popup menu and cap its height.
-- See `:help 'pumblend'` and `:help 'pumheight'`
vim.o.pumblend = 10
vim.o.pumheight = 10

-- ============================================================================
-- Search
-- ============================================================================
-- Case-insensitive searching UNLESS \C or one or more capital letters are in
-- the search term.
-- See `:help 'ignorecase'` and `:help 'smartcase'`
vim.o.ignorecase = true
vim.o.smartcase = true

-- ============================================================================
-- Editing / Indentation / Formatting
-- ============================================================================
-- Use spaces instead of tabs when pressing Tab or auto-indenting.
-- See `:help 'expandtab'`, `:help 'shiftwidth'`, `:help 'tabstop'`
-- and `:help 'softtabstop'`
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- Automatically insert indents based on the current language.
-- See `:help 'smartindent'`
vim.o.smartindent = true

-- Round indentation to a multiple of 'shiftwidth' when shifting lines.
-- See `:help 'shiftround'`
vim.o.shiftround = true

-- Continue visually indented lines when wrapping.
-- See `:help 'breakindent'`
vim.o.breakindent = true

-- Disable soft line wrapping (lines extend beyond the window width).
-- See `:help 'wrap'`
vim.o.wrap = false

-- Smart comment formatting and auto-wrap behavior.
--   j: remove comment leader when joining lines
--   c: autoformat comments
--   r: insert comment leader on <Enter>
--   o: insert comment leader after 'o'/'O'
--   q: gq formats comments
--   l: don't break long lines in insert mode
--   n: recognize numbered lists
--   t: auto-wrap text using textwidth
--   1: don't break a line after a 1-letter word
-- See `:help 'formatoptions'`
vim.o.formatoptions = "jcroqlnt1"

-- Allow the cursor to move past the end of a line in visual block mode.
-- See `:help 'virtualedit'`
vim.o.virtualedit = "block"

-- If an operation would fail due to unsaved changes (e.g. `:q`), raise a dialog
-- asking whether to save.
-- See `:help 'confirm'`
vim.o.confirm = true

-- Automatically write modified buffers before certain actions (e.g. `:make`).
-- See `:help 'autowrite'`
vim.o.autowrite = true

-- Default language for spell checking.
-- See `:help 'spelllang'`
vim.o.spelllang = "en"

-- ============================================================================
-- Clipboard
-- ============================================================================
-- Sync clipboard between OS and Neovim. Schedule after `UiEnter` because it
-- can increase startup time. When connected over SSH, leave clipboard unset so
-- OSC 52 can handle clipboard sync through the terminal emulator.
-- See `:help 'clipboard'` and `:help clipboard-osc52`
vim.schedule(function()
	vim.o.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
end)

-- ============================================================================
-- Scrolling / Cursor positioning
-- ============================================================================
-- Minimal number of screen lines to keep above and below the cursor.
-- See `:help 'scrolloff'`
vim.o.scrolloff = 10

-- Minimum number of screen columns to keep left/right of the cursor.
-- See `:help 'sidescrolloff'`
vim.o.sidescrolloff = 8

-- Enable smooth scrolling (Neovim 0.10+).
-- See `:help 'smoothscroll'`
vim.o.smoothscroll = true

-- ============================================================================
-- Windows / Splits
-- ============================================================================
-- Configure how new splits should be opened.
-- See `:help 'splitright'` and `:help 'splitbelow'`
vim.o.splitright = true
vim.o.splitbelow = true

-- Keep the screen as stable as possible when opening/closing splits.
-- See `:help 'splitkeep'`
vim.o.splitkeep = "screen"

-- Minimum window width when splitting.
-- See `:help 'winminwidth'`
vim.o.winminwidth = 5

-- ============================================================================
-- Completion
-- ============================================================================
-- Control how the completion menu behaves.
-- See `:help 'completeopt'`
vim.o.completeopt = "menu,menuone,noselect"

-- Command-line completion mode: complete longest common prefix first, then
-- show full matches on subsequent presses.
-- See `:help 'wildmode'`
vim.o.wildmode = "longest:full,full"

-- ============================================================================
-- Messages
-- ============================================================================
-- Suppress certain verbose messages (written, intro screen, completion, etc.).
-- See `:help 'shortmess'`
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- ============================================================================
-- Timing
-- ============================================================================
-- Decrease update time for faster CursorHold events and swap file writing.
-- See `:help 'updatetime'`
vim.o.updatetime = 250

-- Decrease mapped sequence wait time (affects which-key and multi-key chords).
-- See `:help 'timeoutlen'`
vim.o.timeoutlen = 300

-- ============================================================================
-- Undo / History
-- ============================================================================
-- Enable undo/redo changes even after closing and reopening a file.
-- See `:help 'undofile'`
vim.o.undofile = true

-- Number of undo levels to keep (much deeper than the default).
-- See `:help 'undolevels'`
vim.o.undolevels = 10000

-- ============================================================================
-- Folding
-- ============================================================================
-- Start with all folds open so they don't collapse by default.
-- See `:help 'foldlevel'`, `:help 'foldmethod'`, and `:help 'foldtext'`
vim.o.foldlevel = 99
vim.o.foldmethod = "indent"
vim.o.foldtext = ""

-- ============================================================================
-- External tools
-- ============================================================================
-- Use ripgrep for `:grep` with a vim-friendly output format.
-- See `:help 'grepprg'` and `:help 'grepformat'`
vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%c:%m"

-- vim: ts=2 sts=2 sw=2 et
