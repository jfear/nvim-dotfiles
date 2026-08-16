# Neovim Keymap Specification

A living spec for the keymap namespace used in this configuration.
The goal is to be mnemonic, LazyVim-aligned where possible, and shallow for
the most common actions.

Leader: `<Space>`  
Local leader: `<Space>`

---

## Principles

1. **Single-letter prefixes are semantic.**
   - `b` = buffer, `c` = code, `f` = file/find, `g` = git, `h` = help,
     `q` = quit/session, `r` = review, `s` = search, `t` = terminal,
     `u` = UI/toggle, `w` = window, `x` = diagnostics/quickfix.
2. **Most-used actions are one or two keys after leader.**
   - Find files: `<leader><space>` or `<leader>ff`
   - Buffers: `<leader>,` or `<leader><leader>`
   - Save: `<C-s>`
   - Quit all: `<leader>qq`
3. **Avoid conflicts with plugin defaults.**
   - `mini.surround` uses `gs*` so Flash can own `s`.
   - `mini.ai` keeps its default next/last prefixes (`an`/`in`/`al`/`il`).
4. **Align with LazyVim conventions** because the user is already familiar
   with them.

---

## Top-level namespace

| Prefix | Group | Notes |
|--------|-------|-------|
| `<leader><tab>` | tabs | |
| `<leader>b` | buffer | |
| `<leader>c` | code | LSP, format, diagnostics |
| `<leader>e` | explorer | `mini.files` |
| `<leader>f` | file / find | Telescope file pickers |
| `<leader>g` | git | Neogit, Gitsigns, Diffview, Octo |
| `<leader>gh` | git hunks | Gitsigns hunk actions |
| `<leader>gp` | PRs (Octo) | GitHub pull requests |
| `<leader>h` | help | help tags, keymaps, etc. |
| `<leader>q` | quit / session | auto-session lives here |
| `<leader>r` | review | `quickfix-review.nvim` |
| `<leader>s` | search | Telescope / grep pickers |
| `<leader>t` | terminal | |
| `<leader>u` | UI / toggle | options, blame, inlay hints |
| `<leader>w` | windows | splits, close, zoom |
| `<leader>x` | diagnostics / quickfix | Trouble |
| `[` | prev | bracket navigation |
| `]` | next | bracket navigation |
| `g` | goto | LSP goto actions |
| `gs` | surround | `mini.surround` |

---

## Global / editing

| Key | Action | Status |
|-----|--------|--------|
| `<Esc>` | clear search highlight + stop snippet | propose |
| `<C-s>` | save file | propose |
| `<leader>qq` | quit all | propose |
| `<leader>ur` | redraw / clear hlsearch / diff update | propose |
| `j` / `k` | respect wrap when `v:count == 0` | optional |
| `n` / `N` | respect `v:searchforward` | propose |
| `<` / `>` (visual) | keep selection | propose |
| `,` / `.` / `;` (insert) | undo break-points | optional |

---

## Buffers (`<leader>b`)

| Key | Action | Status |
|-----|--------|--------|
| `<S-h>` | previous buffer | propose |
| `<S-l>` | next buffer | propose |
| `[b` | previous buffer | propose |
| `]b` | next buffer | propose |
| `<leader><leader>` | switch buffer (Telescope) | keep |
| `<leader>,` | switch buffer (Telescope) | propose alias |
| `<leader>bb` | switch to alternate buffer | propose |
| `<leader>`\` | switch to alternate buffer | propose alias |
| `<leader>bd` | delete buffer (preserve window) | keep |
| `<leader>bD` | delete buffer and window | propose |
| `<leader>bo` | delete other buffers | propose |
| `<leader>bi` | delete invisible buffers | propose |

---

## Code / LSP (`<leader>c`)

### Core LSP goto (no leader)

| Key | Action | Status |
|-----|--------|--------|
| `gd` | goto definition (Telescope) | **missing — add** |
| `gD` | goto declaration | keep |
| `K` | hover | **missing — add** |
| `grr` | references (Telescope) | keep |
| `gri` | implementation (Telescope) | keep |
| `grt` | type definition (Telescope) | keep |
| `gO` | document symbols (Telescope) | keep |
| `gW` | workspace symbols (Telescope) | keep |

### Code actions / format

| Key | Action | Status |
|-----|--------|--------|
| `<leader>ca` | code action | **missing — add** |
| `<leader>cr` | rename | propose alias for `grn` |
| `<leader>cf` | format buffer | **move from `<leader>f`** |
| `<leader>cs` | document symbols | propose |
| `<leader>cS` | workspace symbols | propose |

### Diagnostics

| Key | Action | Status |
|-----|--------|--------|
| `<leader>cd` | line diagnostics (float) | **missing — add** |
| `[d` / `]d` | prev / next diagnostic | propose |
| `[e` / `]e` | prev / next error | propose |
| `[w` / `]w` | prev / next warning | propose |

---

## File / find (`<leader>f`)

Format moves to `<leader>cf`. This prefix is now exclusively for file pickers.

| Key | Action | Status |
|-----|--------|--------|
| `<leader><space>` | find files (root) | propose |
| `<leader>ff` | find files (root) | propose |
| `<leader>fF` | find files (cwd) | propose |
| `<leader>fr` | recent files | propose |
| `<leader>fR` | recent files (cwd) | propose |
| `<leader>fb` | buffers | propose |
| `<leader>fg` | git files | propose |
| `<leader>fc` | find config file | propose |
| `<leader>fn` | find Neovim config files | keep (move from `<leader>sn`) |

---

## Search (`<leader>s`)

| Key | Action | Status |
|-----|--------|--------|
| `<leader>sh` | help tags | keep |
| `<leader>sk` | keymaps | keep |
| `<leader>sw` | search current word | keep |
| `<leader>sW` | search current word (cwd) | propose |
| `<leader>sg` | live grep (root) | keep |
| `<leader>sG` | live grep (cwd) | propose |
| `<leader>sd` | diagnostics | keep |
| `<leader>sD` | buffer diagnostics | propose |
| `<leader>sr` / `<leader>sR` | resume | keep / alias |
| `<leader>s.` | recent files | keep |
| `<leader>sc` | commands | keep |
| `<leader>sb` | buffer lines | propose |
| `<leader>s/` | grep open files | keep |
| `<leader>/` | current buffer fuzzy find | keep |
| `<leader>sH` | search hunks (all files) | keep |

---

## Git (`<leader>g`)

### Neogit (lowercase = everyday git)

| Key | Action | Status |
|-----|--------|--------|
| `<leader>gg` | Neogit status | keep |
| `<leader>gc` | Neogit commit | keep |
| `<leader>gP` | Neogit push | keep (capital P = Push) |
| `<leader>gb` | Neogit branch | keep |
| `<leader>gl` | Neogit log | keep |

### Octo (GitHub-specific)

| Key | Action | Status |
|-----|--------|--------|
| `<leader>gp` | PR list | **flatten from `<leader>gpo`** |
| `<leader>gI` | issue list | **flatten from `<leader>gpi`** |
| `<leader>gr` | review start | **flatten from `<leader>gpr`** |
| `<leader>gN` | PR create | **flatten from `<leader>gpn`** |
| `<leader>gC` | PR checkout | **flatten from `<leader>gpc`** |

### Diffview

| Key | Action | Status |
|-----|--------|--------|
| `<leader>gd` | Diffview open | keep |
| `<leader>gf` | file history | keep |

### Gitsigns hunks (`<leader>gh`)

Move hunk actions from `<leader>h` to `<leader>gh`.

| Key | Action | Status |
|-----|--------|--------|
| `<leader>ghs` | stage hunk | move |
| `<leader>ghr` | reset hunk | move |
| `<leader>ghS` | stage buffer | move |
| `<leader>ghR` | reset buffer | move |
| `<leader>ghp` | preview hunk | move |
| `<leader>ghi` | preview hunk inline | move |
| `<leader>ghb` | blame line | move |
| `<leader>ghd` | diff this | move |
| `<leader>ghD` | diff this `~` | move |
| `<leader>ghq` | hunks → quickfix (this file) | move |
| `<leader>ghQ` | hunks → quickfix (all files) | move |
| `]h` / `[h` | next / prev hunk | keep |
| `ih` (operator/x) | select hunk | keep |

---

## UI / toggles (`<leader>u`)

Move toggles from `<leader>t*` and `<leader>H` here.

| Key | Action | Status |
|-----|--------|--------|
| `<leader>uH` | toggle search highlight | move from `<leader>H` |
| `<leader>ub` | toggle blame line | move from `<leader>tb` |
| `<leader>uw` | toggle word diff | move from `<leader>tw` |
| `<leader>ug` | toggle diff base (main/master) | move from `<leader>tg` |
| `<leader>uh` | toggle inlay hints | move from `<leader>th` |

Optional LazyVim-style toggles:

| Key | Action |
|-----|--------|
| `<leader>us` | spell |
| `<leader>uw` | wrap |
| `<leader>uL` | relative line number |
| `<leader>ud` | diagnostics |
| `<leader>ul` | line number |
| `<leader>uc` | conceal level |

---

## Terminal (`<leader>t`)

| Key | Action | Status |
|-----|--------|--------|
| `<leader>tt` | terminal (cwd) | propose |
| `<leader>tT` | terminal (root) | propose |
| `<C-/>` | toggle terminal | propose |
| `<Esc><Esc>` | exit terminal mode | keep |

---

## Windows (`<leader>w`)

| Key | Action | Status |
|-----|--------|--------|
| `<C-h/j/k/l>` | window navigation | keep |
| `<leader>-` | split below | propose |
| `<leader>|` | split right | propose |
| `<leader>wd` | delete window | propose |
| `<leader>wm` | maximize window | optional |

---

## Diagnostics / quickfix (`<leader>x`)

| Key | Action | Status |
|-----|--------|--------|
| `<leader>xx` | Trouble diagnostics | keep |
| `<leader>xX` | buffer diagnostics | keep |
| `<leader>xL` | location list | keep |
| `<leader>xQ` | quickfix list | keep |
| `[q` / `]q` | prev / next quickfix item | keep |

---

## Review (`<leader>r`) — `quickfix-review.nvim`

Move **all** review keymaps from `<leader>c*` to `<leader>r*`.

| Key | Action | Old key |
|-----|--------|---------|
| `<leader>ra` | add comment (cycle) | `<leader>ca` |
| `<leader>ri` | add ISSUE | `<leader>ci` |
| `<leader>rs` | add SUGGESTION | `<leader>cs` |
| `<leader>rn` | add NOTE | `<leader>cn` |
| `<leader>rp` | add PRAISE | `<leader>cp` |
| `<leader>rq` | add QUESTION | `<leader>cq` |
| `<leader>rk` | add INSIGHT | `<leader>ck` |
| `<leader>rA` | add AGENT | `<leader>cA` |
| `<leader>rd` | delete comment | `<leader>cd` |
| `<leader>re` | export review | `<leader>ce` |
| `<leader>rc` | clear review | `<leader>cc` |
| `<leader>rS` | summary | `<leader>cS` |
| `<leader>rw` | save review | `<leader>cw` |
| `<leader>rr` | load review | `<leader>crr` |
| `<leader>ro` | open quickfix list | `<leader>co` |
| `<leader>rg` | goto real file | `<leader>cg` |
| `<leader>rv` | view comment | `<leader>cv` |
| `]r` / `[r` | next / prev comment | keep |
| `<M-+>` / `<M-->` | cycle comment type | keep |

---

## Sessions (`<leader>q`)

Move auto-session keymaps from `<leader>a*` to `<leader>q*`.

| Key | Action | Old key |
|-----|--------|---------|
| `<leader>qs` | save session | `<leader>as` |
| `<leader>qr` | restore session | `<leader>ar` |
| `<leader>qf` | find session | `<leader>af` |
| `<leader>qd` | delete session | `<leader>ad` |

---

## Help (`<leader>h`)

Proposed additions (currently mostly under `<leader>s`):

| Key | Action |
|-----|--------|
| `<leader>hh` | help tags |
| `<leader>hk` | keymaps |
| `<leader>hc` | commands |
| `<leader>ho` | options |

> **Note:** We can keep the existing `<leader>sh/sk/sc` aliases for
> LazyVim compatibility; `<leader>h` just provides a more intuitive group.

---

## Surround (`gs*`)

Change `mini.surround` defaults to avoid conflict with Flash `s`.

| Key | Action |
|-----|--------|
| `gsa` | add surrounding |
| `gsd` | delete surrounding |
| `gsr` | replace surrounding |
| `gsf` | find surrounding (right) |
| `gsF` | find surrounding (left) |
| `gsh` | highlight surrounding |
| `gsn` | update `n_lines` |

---

## mini.ai / treesitter-textobjects

Keep both plugins but resolve the `aa` collision.

- `mini.ai`: use default next/last mappings (`an`/`in`/`al`/`il`).
- `treesitter-textobjects`: keep `af/if/ac/ic/aa/ia` for function/class/parameter.

---

## Default plugin keymaps to remember

These are active even though they are not explicitly set in our config:

| Plugin | Key(s) | Action |
|--------|--------|--------|
| `flash.nvim` | `s`, `S`, `<C-s>` | jump, treesitter, toggle in search |
| `yanky.nvim` | `y/p/P/gp/gP`, `<C-p/n>`, `]p/[p`, `>p/<p/=p` | yank-ring put/cycle |
| `dial.nvim` | `<C-a/x>`, `g<C-a/x>` | increment/decrement |
| `mini.move` | `<M-h/j/k/l>` | move lines/selections |
| `mini.align` | `ga` (visual) | align |
| `mini.operators` | `g=`, `cx`, `cr`, `gm` | evaluate, exchange, replace, multiply |
| `mini.splitjoin` | `gS`, `gJ` | split/join expression |
| `mini.bracketed` | `]b/d/q/x/c/o/t/j/w/i/y`, `[...]` | bracket navigation |
| `mini.pairs` | auto `()`, `[]`, `{}`, quotes | auto-pairs |
| `treesitter-textobjects` | `af/if/ac/ic/aa/ia`, `]f/F/c/C/a/A` | textobjects |
| `blink.cmp` | `<Tab>`, `<S-Tab>`, `<CR>` | completion (super-tab preset) |

---

## which-key groups

Update `lua/plugins/which-key.lua` to:

```lua
spec = {
  { "<leader><tab>", group = "tabs" },
  { "<leader>b", group = "buffer" },
  { "<leader>c", group = "code" },
  { "<leader>e", group = "explorer" },
  { "<leader>f", group = "file/find" },
  { "<leader>g", group = "git" },
  { "<leader>gh", group = "git hunks" },
  { "<leader>gp", group = "PRs (Octo)" },
  { "<leader>h", group = "help" },
  { "<leader>q", group = "quit/session" },
  { "<leader>r", group = "review" },
  { "<leader>s", group = "search", mode = { "n", "v" } },
  { "<leader>t", group = "terminal" },
  { "<leader>u", group = "ui/toggle" },
  { "<leader>w", group = "windows" },
  { "<leader>x", group = "diagnostics/quickfix" },
  { "[", group = "prev" },
  { "]", group = "next" },
  { "g", group = "goto" },
  { "gs", group = "surround" },
}
```

---

## Implementation checklist

Use this checklist when applying the spec section by section.

- [ ] Global keymaps (`keymaps.lua`): save, quit, buffer nav, search, window splits
- [ ] LSP: add `gd`, `K`, `<leader>ca`, `<leader>cr`, `<leader>cd`, diagnostic jumps
- [ ] Format: move `<leader>f` → `<leader>cf`
- [ ] File/find: add `<leader>f*` prefix mappings
- [ ] Search: add cwd variants / aliases
- [ ] Git hunks: move `<leader>h*` → `<leader>gh*`
- [ ] Octo: flatten `<leader>gpo/gpc/gpr/gpi/gpn`
- [ ] Toggles: move to `<leader>u*`
- [ ] Terminal: add `<leader>t*` and `<C-/>`
- [ ] Review: move `<leader>c*` → `<leader>r*`
- [ ] Sessions: move `<leader>a*` → `<leader>q*`
- [ ] `mini.surround`: switch to `gs*`
- [ ] `mini.ai`: revert to default `an/in/al/il`
- [ ] `which-key`: update groups
- [ ] Update `README.md` or this spec with any deviations
