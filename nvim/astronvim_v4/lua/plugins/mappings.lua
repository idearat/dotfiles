-- ---
-- Intro
-- ---

-- comprehensive mapping file containing comments describing each of the
-- mappings found in a standard NeoVim configuration so it's easy to see
-- what keys make the most sense for remapping and how the remapping may
-- relate functionally or mnemonically to the original key.

local function enhance_maps(maps)

  local core = require "astrocore"
  local ui = require "astroui"

  local notify = core.notify

  local telescope = require "telescope.builtin"
  local helpers = require "helpers"

  -- notify "user.mappings executed"

  local function dismiss()
    notify.dismiss {}
    vim.cmd "CloseFloatingWindows"
  end

  local function vimhelp()
    local ok, _result = pcall(vim.cmd, "help " .. vim.fn.expand "<cword>")
    if not ok then notify("No help for " .. vim.fn.expand "<cword>") end
  end

  -- ensure needed slots are initialized
  maps.i = maps.i or {}
  maps.n = maps.n or {}
  maps.t = maps.t or {}
  maps.v = maps.v or {}
  maps.x = maps.x or {}

  -- in-display footnote documentation for altered mappings
  maps.n["1"] = { "1", desc = "¹ Enhances Original" }
  maps.n["2"] = { "2", desc = "² Similar To Original" }
  maps.n["3"] = { "3", desc = "³ New Functionality" }

  -- ---------
  -- Solo Keys
  -- ---------

  -- Most of these are first-order change or movement operations.

  -- LOWERCASE

  maps.n["a"] = { "a", desc = "Append Mode" }
  maps.n["b"] = { "b", desc = "Previous Word" }
  maps.n["c"] = { "c", desc = "Change Operator" }
  maps.n["d"] = { "d", desc = "Delete Operator" }
  maps.n["e"] = { "e", desc = "End Of Word" }

  -- NOTE: flit.nvim's mappings don't appear to be "updatable"
  -- maps.n["f"] = { desc = "Find Char In Line" }
  -- maps.n["f"] = { "f", desc = "Leap Ahead To ch ²" }

  maps.n["g"] = { "g", desc = "Go Operator" }
  maps.n["h"] = { "h", desc = "Move Left" }
  maps.n["i"] = { "i", desc = "Insert Mode" }
  maps.n["j"] = { "j", desc = "Move Down" }
  maps.n["k"] = { "k", desc = "Move Up" }
  maps.n["l"] = { "l", desc = "Move Right" }
  maps.n["m"] = { "m", desc = "Mark" }

  -- maps.n["n"] = { desc = "Next Match" }
  maps.n["n"] = { "nzzzv", desc = "Next Match ¹" }

  -- maps.n["o"] = { desc = "Open Line" }
  maps.n["o"] = { [[o<esc>^"_Da]], desc = "Open Below ¹" }

  maps.n["p"] = { "p", desc = "Paste" }
  maps.n["q"] = { "q", desc = "Record On/Off" }
  maps.n["r"] = { "r", desc = "Replace Char(s)" }

  -- SEE lsp/mappings.lua
  -- maps.n["s"] = { desc = "Substitute Char(s) (syn cl)" }
  -- maps.n["s"] = { "s", desc = "Leap Ahead To chch ³" }

  -- NOTE: flit.nvim's mappings don't appear to be "updatable"
  -- maps.n["t"] = { desc = "Find Char In Line*" }
  -- maps.n["t"] = { "t", desc = "Leap Ahead to ch-1 ²" }

  maps.n["u"] = { "u", desc = "Undo" }
  maps.n["v"] = { "v", desc = "Visual Mode" }
  maps.n["w"] = { "w", desc = "Next Word" }
  maps.n["x"] = { "x", desc = "Delete Char" }
  maps.n["y"] = { "y", desc = "Yank Operator" }
  maps.n["z"] = { "z", desc = "Position/Fold" }

  -- UPPERCASE

  -- Most of these are second-order change or movement operations with a few
  -- informational operations thrown in (blame, diagnostics, help, etc.).

  maps.n["A"] = { "A", desc = "Append At End" }

  -- maps.n["B"] = { desc = "(== b)" }
  maps.n["B"] =
    { function() require("gitsigns").blame_line { full = false } end, desc = "Git Blame ³" }

  maps.n["C"] = { "C", desc = "Delete To EOL+i" }
  maps.n["D"] = { "D", desc = "Delete To EOL" }

  -- maps.n["E"] = { desc = "(== e)" }
  maps.n["E"] = { helpers.eval, desc = "Evaluate (Debug) ³" }
  maps.v["E"] = { helpers.eval, desc = "Evaluate (Debug) ³" }

  -- NOTE: flit.nvim's mappings don't appear to be "updatable"
  -- maps.n["F"] = { desc = "Reverse f" }
  -- maps.n["F"] = { "F", desc = "Reverse f ²" }

  maps.n["G"] = { "G", desc = "Line n | EOF" }

  -- maps.n["H"] = { desc = "(~ yH)" }
  maps.n["H"] = { vimhelp, desc = "Help @ Cursor ³" }

  maps.n["I"] = { "I", desc = "Insert At Start" }

  -- maps.n["J"] = { desc = "Join Lines" }
  maps.n["J"] = { "mzJ`z", desc = "Join Lines ¹" }

  -- NOTE: "K" is a special case since it remaps an LSP mapping. As a
  -- result the 'desc' remapping is done in the lsp/mappings.lua file.
  -- maps.n["K"] = { desc = "Filter Thru keywordprg (man or help)" }
  -- maps.n["K"] = { function() vim.lsp.buf.hover() end, desc = "Keyword Help ³" }

  -- maps.n["L"] = { desc = "(~ yL)" }
  maps.n["L"] = { function() vim.diagnostic.open_float() end, desc = "Lint / Diagnostics ³" }

  maps.n["M"] = { function() notify(ui.get_hlgroup()) end, desc = "Highlight Mapping ³" }

  -- maps.n["N"] = { desc = "Reverse n" }
  maps.n["N"] = { "Nzzzv", desc = "Reverse n ¹" }

  -- maps.n["O"] = { desc = "Open Above" }
  maps.n["O"] = { [[O<esc>^"_Da]], desc = "Open Above ¹" }

  maps.n["P"] = { "P", desc = "Paste Above" }

  -- maps.n["Q"] = { desc = "Repeat Last Recorded Register" }
  maps.n["Q"] = { [[@q]], desc = "Re-Run @q ³" }

  maps.n["R"] = { "R", desc = "Replace Mode" }

  -- SEE lsp/mappings.lua
  -- maps.n["S"] = { desc = "Delete Lines + Insert (syn cc)" }
  -- maps.n["S"] = { "S", desc = "Reverse s ³" }

  -- NOTE: flit.nvim's mappings don't appear to be "updatable"
  -- maps.n["T"] = { desc = "Reverse t" }
  -- maps.n["T"] = { "T", desc = "Reverse t ²" }

  -- maps.n["U"] = { desc = "Undo Line Changes" }
  maps.n["U"] = { ":UndotreeToggle<cr>", desc = "Undotree Toggle ³" }

  maps.n["V"] = { "V", desc = "Visual Line Mode" }

  maps.n["W"] = { function() telescope.lsp_references() end, desc = "Where In Workspace ³" }

  maps.n["X"] = { "X", desc = "Reverse x" }

  -- maps.n["Y"] = { desc = "Yank Lines (syn yy)" }
  -- maps.n["Y"] = { desc = "(== yy)" }
  maps.n["Y"] = { "y$", desc = "Yank To EOL ³" }

  -- maps.n["Z"] = { desc = "ZZ (:x) or ZQ (:q!)" }
  maps.n["Z"] = { "Z", desc = "ZZ / ZQ Prefix" }

  -- SYMBOLS

  -- Additional change and movement operations.

  maps.n["~"] = { "~", desc = "Toggle Case" }
  maps.n["!"] = { "!", desc = "Filter Via extern" }
  maps.n["@"] = { "@", desc = "Execute Register" }
  maps.n["#"] = { "#", desc = "Reverse *" }
  maps.n["$"] = { "$", desc = "End Of Line" }
  maps.n["%"] = { "%", desc = "Match Pair ()[]{}*" }
  maps.n["^"] = { "^", desc = "First ch On Line" }

  -- NOTE: this one's less useful with 's' mapped to Leap
  maps.n["&"] = { "&", desc = "Repeat Substitution" }

  maps.n["*"] = { "*", desc = "Next Word @ Cursor" }

  maps.n["("] = { "(", desc = "Back n Sentence(s)" }
  maps.n[")"] = { ")", desc = "Ahead n Sentence(s)" }

  -- maps.n["_"] = { desc = "Non-Blank Char Next N-1 Lines" }
  maps.n["_"] =
    { ":lua vim.diagnostic.goto_next({float = true })<cr>", desc = "Next Diagnostic ³" }

  maps.n["+"] = { "+", desc = "Ahead n Lines+^" }

  -- NOTE: not shown by which-key
  maps.n["`"] = { "`", desc = "Jump To Mark" }

  -- maps.n["1-9"] = { desc = "Move/Repeat Count" }

  maps.n["0"] = { "0", desc = "Move To Column 0" }

  maps.n["-"] = { "-", desc = "Back n Lines+^" }

  maps.n["="] = { "=", desc = "Filter Via equalprg" }

  maps.n["{"] = { "{", desc = "Back n Paragraph(s)" }
  maps.n["}"] = { "}", desc = "Ahead n Paragraph(s)" }

  maps.n["["] = { "[", desc = "Previous n {...} ¹" }
  maps.n["]"] = { "]", desc = "Next n {...} ¹" }

  -- maps.n["|"] = { desc = "AstroNvim Vertical Split" }
  helpers.removekey(maps.n, "|") -- unmap AstroNvim, preserve column movement
  maps.n["|"] = { "|", desc = "Screen Column n" }

  -- maps.n["\\"] = { desc = "(\x reserved)" }
  -- maps.n["\\"] = { desc = "AstroNvim Horizontal Split"" }
  -- helpers.removekey(maps.n, "\\") -- unmap, use for something else
  maps.n["\\"] = { ":ZenMode<cr>", desc = "ZenMode Toggle ³" }

  maps.n[":"] = { ":", desc = "Command Mode" }
  -- maps.n[";"] = { desc = "Repeat fFtT" }
  -- maps.n[";"] = { ":ZenMode<cr>", desc = "ZenMode Toggle ³" }
  maps.n[";"] = { ":", desc = "Command Mode ³" }

  -- NOTE: not shown by which-key
  maps.n['"'] = { '"', desc = "Use Register (dyp)" }

  -- NOTE: not shown by which-key
  maps.n["'"] = { "'", desc = "Jump To Mark Line" }

  maps.n["<"] = { desc = "Shift Left" }
  maps.n[">"] = { desc = "Shift Right" }

  -- maps.n[","] = { desc = "Reverse fFtT" }
  maps.n[","] = { "<Localleader>", desc = "Local Leader ³" } -- buffer-local leader
  maps.n["."] = { ".", desc = "Repeat Last Cmd" }

  maps.n["?"] = { "?", desc = "Search Back" }
  maps.n["/"] = { "/", desc = "Search Ahead" }

  -- SPECIALS

  -- maps.n["<Esc>"] = { desc = "Normal|Close|Exit" }

  -- maps.n["<tab>"] = { desc = "" }
  maps.n["<Tab>"] = {
    function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Next Buffer ³",
  }

  maps.n["<S-Tab>"] = {
    function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    desc = "Previous Buffer ³",
  }

  maps.n["<CR>"] = { "<CR>", desc = "Ahead n Lines+^" }

  maps.n["<Space>"] = { desc = "Global Leader ³" }

  -- FUNCTION KEYS

  -- TODO: complete mappings for F1-F20

  maps.n["<F1>"] = { "<F1>", desc = "Help" }
  maps.n["<F2>"] = { function() notify "<F2>" end, desc = "F2 ³" }
  maps.n["<F3>"] = { function() notify "<F3>" end, desc = "F3 ³" }
  maps.n["<F4>"] = { function() notify "<F4>" end, desc = "F4 ³" }
  maps.n["<F5>"] = { function() notify "<F5>" end, desc = "F5 ³" }
  maps.n["<F6>"] = { function() notify "<F6>" end, desc = "F6 ³" }
  maps.n["<F7>"] = { function() require("dapui").toggle() end, desc = "Debugger: UI ³" }
  maps.n["<F8>"] = { function() notify "<F8>" end, desc = "F8 ³" }
  maps.n["<F9>"] = { function() notify "<F9>" end, desc = "F9 ³" }
  maps.n["<F10>"] = { function() notify "<F10>" end, desc = "F10 ³" }

  maps.n["<F11>"] = { function() notify "<F11>" end, desc = "F11 ³" }
  maps.n["<F12>"] = { function() notify "<F12>" end, desc = "F12 ³" }
  maps.n["<F13>"] = { function() notify "<F13>" end, desc = "F13 ³" }

  -- NOTE: the following keys are largely ignored / unmappable on my keyboard
  -- maps.n["<F14>"] = { function() notify "<F14>" end, desc = "F14 ³" }
  -- maps.n["<F15>"] = { function() notify "<F15>" end, desc = "F15 ³" }
  -- maps.n["<F16>"] = { function() notify "<F16>" end, desc = "F16 ³" }
  -- maps.n["<F17>"] = { function() notify "<F17>" end, desc = "F17 ³" }
  -- maps.n["<F18>"] = { function() notify "<F18>" end, desc = "F18 ³" }
  -- maps.n["<F19>"] = { function() notify "<F19>" end, desc = "F19 ³" }
  -- maps.n["<F20>"] = { function() notify "<F20>" end, desc = "F20 ³" }

  -- TODO: map debugger keys to keys we actually have ;)
  maps.n["<F9>"] = { "<F9>", desc = "Debugger: Breakpoint" }
  maps.n["<F21>"] = { "<F21>", desc = "Debugger: Conditional" }

  -- -------------
  -- Alt/Meta Keys
  -- -------------

  -- ---------
  -- Ctrl Keys
  -- ---------

  -- primarily large movement across pages, splits, windows, etc.

  -- LETTERS (non-shifted... which-key will normalize to uppercase in display)

  maps.n["<C-a>"] = { "[{V%", desc = "Select Block ³" }
  maps.x["<C-a>"] = { [["_[{V%]], desc = "Select Block ³" } -- TODO: fix it

  maps.n["<C-b>"] = { "<C-b>", desc = "Cursor Back n Pages" }
  maps.n["<C-c>"] = { "<C-c>", desc = "Interrupt / Cancel" }
  maps.n["<C-d>"] = { "<C-d>", desc = "Cursor Down n Lines" }
  maps.n["<C-e>"] = { "<C-e>", desc = "Scroll Down n Lines" }
  maps.n["<C-f>"] = { "<C-f>", desc = "Cursor Down n Pages" }

  -- maps.n["<C-g>"] = { desc = "File Info - countCtrl-G expands" }
  maps.n["<C-g>"] = { "3<C-g>", desc = "File Path Info ¹" }

  maps.n["<C-h>"] = { "<C-w>h", desc = "Move To Left Split" }

  -- Not displayed by which-key (paired with C-o for jumplist movement).
  -- maps.n["<C-i>"] = { desc = "+n In Jump List" }

  maps.n["<C-j>"] = { "<C-w>j", desc = "Move To Below Split" }
  maps.n["<C-k>"] = { "<C-w>k", desc = "Move To Above Split" }
  maps.n["<C-l>"] = { "<C-w>l", desc = "Move To Right Split" }

  -- skip describing this one... which-key doesn't show <C-M> anyway
  -- maps.n["<C-m>"] = { desc = "<CR>" }

  -- maps.n["<C-n>"] = { desc = "(== j)" }
  maps.n["<C-n>"] = {
    ":lua vim.diagnostic.goto_next({float = true, severity = vim.diagnostic.severity.ERROR})<cr>",
    desc = "Next Error ³",
  }

  -- maps.n["<C-o>"] = { desc = "Jump List" }
  maps.n["<C-o>"] = { "<C-o>", desc = "-n In Jump List" }

  -- maps.n["<C-p>"] = { desc = "(== k)" }
  maps.n["<C-p>"] = {
    ":lua vim.diagnostic.goto_prev({float = true, severity = vim.diagnostic.severity.ERROR})<cr>",
    desc = "Previous Error ³",
  }

  -- SEE lsp/mappings.lua
  -- maps.n["<C-q>"] = { desc = "(== <C-v>)" }
  helpers.removekey(maps.n, "<C-q>") -- unmap AstroNvim's quit

  maps.n["<C-r>"] = { "<C-r>", desc = "Redo n Undos" }

  -- SEE lsp/mappings.lua
  -- maps.n["<C-s>"] = { desc = "" }
  helpers.removekey(maps.n, "<C-s>") -- unmap AstroNvim's save
  maps.n["<C-s>"] = { ":w!<cr>", desc = "Save! File ³" }

  -- NOTE: remapped since tags aren't used in this configuration.
  -- maps.n["<C-t>"] = { "<C-t>", desc = "-n In Tag Stack" }
  maps.n["<C-t>"] = { ":TodoTelescope<cr>", desc = "Todo List ³" }

  maps.n["<C-u>"] = { "<C-u>", desc = "Cursor Up n Lines" }
  maps.n["<C-v>"] = { "<C-v>", desc = "Visual Block Mode" }
  maps.n["<C-w>"] = { "<C-w>", desc = "Window Command" }

  -- SEE lsp/mappings.lua
  -- maps.n["<C-x>"] = { desc = "Subtract From Number" }
  helpers.removekey(maps.n, "<C-x>") -- unmap AstroNvim's save & quit

  maps.n["<C-y>"] = { "<C-y>", desc = "Scroll Up n Lines" }

  -- NOTE: insert mode here for completion (matches zsh bindkey C-y)
  -- and with iTerm2 mapping C-CR to send 0x19 we can use C-CR in vim.
  maps.i["<C-y>"] = { "<C-y>", desc = "Accept Completion ³" }

  maps.n["<C-z>"] = { "<C-z>", desc = "Suspend Program" }

  -- SYMBOLS (unshifted)

  maps.n["<C-`>"] = { function() telescope.marks() end, desc = "Find Mark ³" }

  -- maps.n["<C-[1-5]>"] = { desc = "" }

  -- maps.n["<C-6>"] = { desc = "Prior Buffer" }
  maps.n["<C-^>"] = { "<C-^>", desc = "Prior Buffer" }

  -- maps.n["<C-[7-0]>"] = { desc = "" }

  maps.n["<C-*>"] = { function() telescope.grep_string() end, desc = "Find All @ Cursor" }

  maps.n["<C-->"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Comment Toggle ³",
  }
  maps.v["<C-->"] = {
    "<esc>:lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    desc = "Comment Toggle ³",
  }

  maps.n["<C-=>"] =
    { function() vim.lsp.buf.format() end, desc = "Format Buffer ³" }

  -- NOTE: these don't appear to work properly (they just use [ or ] mapping)
  -- maps.n["<C-{>"] = { desc = "" }
  -- maps.n["<C-}>"] = { desc = "" }

  -- NOTE: <C-[> is equivalent to <esc>, remap this and you remap Esc. Don't.
  -- maps.n["<C-[>"] = { desc = "<esc>" }

  -- default is "find tag" so mapped to find across files.
  maps.n["<C-]>"] = {
    function()
      telescope.live_grep {
        additional_args = function(args)
          return vim.list_extend(args, { hidden = false, no_ignore = false })
        end,
      }
    end,
    desc = "Find Text In All ³",
  }

  -- NOTE: this doesn't work as expected, it just uses the '\' mapping.
  -- maps.n["<C-|>"] = { desc = "" }

  maps.n["<C-\\>"] = { function() require("FTerm").toggle() end, desc = "Terminal Toggle ³" }
  maps.t["<C-\\>"] = { function() require("FTerm").toggle() end, desc = "Terminal Toggle ³" }

  -- NOTE: this doesn't work as expected, it just uses the ';' mapping.
  -- maps.n["<C-:>"] = { desc = "" }

  maps.n["<C-;>"] = { function() telescope.diagnostics() end, desc = "Find Diagnostic ³" }

  -- NOTE: shifted
  maps.n['<C-">'] = { function() telescope.registers() end, desc = "Find Register ³" }

  maps.n["<C-'>"] = { function() telescope.marks() end, desc = "Find Mark ³" }

  -- NOTE: this key superceded by iTerm2 mapping (when set) to send 0x19 ^y
  -- to support autocompletion (or simply scrolling up/down in normal mode).
  maps.n["<C-CR>"] = { "C-y", desc = "C-y ³" }

  maps.n["<C-S-CR>"] = { dismiss, desc = "Dismiss Notices ³" }

  -- NOTE: this works... but seems to be a bit of a hack since pair doesn't.
  -- maps.n["<C-<>"] = { function() notify "TODO - ?prev?" end, desc = "TODO - ?prev?" }

  -- NOTE: this doesn't work, C-S-. ends up being a trigger for something else.
  maps.n["<C->>"] = { function() notify "TODO - ?next?" end, desc = "TODO - ?next?" }

  maps.n["<C-,>"] = { function() telescope.buffers() end, desc = "Find Buffer" }

  maps.n["<C-.>"] = { function() telescope.commands() end, desc = "Find Command" }

  maps.n["<C-/>"] =
    { function() telescope.current_buffer_fuzzy_find() end, desc = "Find In Buffer ³" }

  -- ----------
  -- Arrow Keys
  -- ----------

  maps.n["<S-Up>"] = { ":resize -2<cr>", desc = "Resize Split Up ³" }
  maps.n["<S-Down>"] = { ":resize +2<cr>", desc = "Resize Split Down ³" }
  maps.n["<S-Left>"] = { ":vertical resize +2<cr>", desc = "Resize Split Left ³" }
  maps.n["<S-Right>"] = { ":vertical resize -2<cr>", desc = "Resize Split Right ³" }

  maps.n["<C-Up>"] = { function() notify "TODO - ??? ³" end, desc = "??? ³" }
  maps.n["<C-Down>"] = { function() notify "TODO - ??? ³" end, desc = "??? ³" }
  maps.n["<C-Left>"] = { function() notify "TODO - ??? ³" end, desc = "??? ³" }
  maps.n["<C-Right>"] = { function() notify "TODO - ??? ³" end, desc = "??? ³" }

  -- -----------
  -- Leader Keys
  -- -----------

  maps.n["<Leader>a"] = { ":AerialToggle<cr>", desc = "Aerial Toggle" }

  -- Buffer Menu

  maps.n["<Leader>b"] = { "<Leader>b", desc = ui.get_icon("Tab", 1, true) .. "Buffer Menu" }
  maps.n["<Leader>bf"] = { function() telescope.buffers() end, desc = "Find Buffer" }
  maps.n["<Leader>bN"] = { "<cmd>enew<cr>", desc = "New File/Buffer" }
  maps.n["<Leader>bo"] =
    { function() require("astrocore.buffer").close_all(true) end, desc = "Only Buffer" }

  helpers.removekey(maps.n, "<Leader>b\\") -- unmap AstroNvim's save & quit
  helpers.removekey(maps.n, "<Leader>b|") -- unmap AstroNvim's save & quit
  maps.n["<Leader>bb"] = { "<Leader>bb", desc = "Select From Tabline" }
  maps.n["<Leader>bc"] = {
    function()
      local bufs = vim.fn.getbufinfo { buflisted = true }
      require("astrocore.buffer").close(0)
      if core.is_available "alpha-nvim" and not bufs[2] then
        require("alpha").start(true)
      end
    end,
    desc = "Close Buffer",
  }
  maps.n["<Leader>bC"] = { "<Leader>bC", desc = "Close All" }
  maps.n["<Leader>bd"] = { "<Leader>bd", desc = "Close From Tabline" }
  maps.n["<Leader>bl"] = { "<Leader>bl", desc = "Close All To Left" }
  maps.n["<Leader>bp"] = { "<Leader>bp", desc = "Previous Buffer" }
  maps.n["<Leader>br"] = { "<Leader>br", desc = "Close All To Right" }

  -- Chat Menu

  maps.n["<Leader>c"] =
    { "<Leader>c", desc = ui.get_icon("DiagnosticHint", 1, true) .. "Chat/AI Menu" }

  maps.n["<Leader>ca"] = { ":GpAppend<cr>", desc = "Append" }
  maps.n["<Leader>cA"] = { ":GpWhisperAppend<cr>", desc = "Whisper Append" }

  maps.n["<Leader>cb"] = { ":GpEnew<cr>", desc = "Buffer" }
  maps.n["<Leader>cB"] = { ":GpWhisperEnew<cr>", desc = "Whisper Buffer" }

  maps.n["<Leader>cc"] = { ":GpChatNew<cr>", desc = "Chat (new)" }

  maps.n["<Leader>cd"] = { ":GpChatDelete<cr>", desc = "Delete Chat" }

  maps.n["<Leader>cf"] = { ":GpChatFinder<cr>", desc = "Find Chat" }

  maps.n["<Leader>ch"] = { ":GpChatNew split<cr>", desc = "H-Split" }
  maps.n["<Leader>cH"] = { ":GpWhisperNew split<cr>", desc = "Whisper H-Split" }

  maps.n["<Leader>cn"] = { ":GpAgentNext<cr>", desc = "Next Agent" }

  maps.n["<Leader>cp"] = { ":GpPrepend<cr>", desc = "Prepend" }
  maps.n["<Leader>cP"] = { ":GpWhisperPrepend<cr>", desc = "Whisper Prepend" }

  maps.n["<Leader>cr"] = { ":GpRewrite<cr>", desc = "Rewrite" }
  maps.n["<Leader>cR"] = { ":GpWhisperRewrite<cr>", desc = "Whisper Rewrite" }

  maps.n["<Leader>cs"] = { ":GpStop<cr>", desc = "Stop All" }

  maps.n["<Leader>ct"] = { ":GpChatToggle split<cr>", desc = "Toggle Chat" }

  maps.n["<Leader>cv"] = { ":GpChatNew vsplit<cr>", desc = "V-Split" }
  maps.n["<Leader>cV"] = { ":GpWhisperNew vsplit<cr>", desc = "Whisper V-Split" }

  maps.n["<Leader>cw"] = { ":GpWhisper<cr>", desc = "Whisper" }

  maps.n["<Leader>cx"] = { ":GpContext<cr>", desc = "Toggle Context" }

  -- Debugger Menu

  maps.n["<Leader>d"] = { "<Leader>d", desc = ui.get_icon("Debugger", 1, true) .. "Debugger Menu" }

  maps.n["<Leader>e"] = { ":Neotree toggle<cr>", desc = "Explorer Toggle" }

  -- Find Menu

  maps.n["<Leader>f"] = { "<Leader>f", desc = ui.get_icon("Search", 1, true) .. "Find Menu" }

  -- Git Menu

  maps.n["<Leader>g"] = { "<Leader>g", desc = ui.get_icon("Git", 1, true) .. "Git Menu" }

  -- From Astronvim (if gitsigns)
  -- maps.n["]g"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" }
  -- maps.n["[g"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" }
  -- maps.n["<Leader>gl"] = { function() require("gitsigns").blame_line() end, desc = "View Git blame" }
  -- maps.n["<Leader>gL"] = { function() require("gitsigns").blame_line { full = true } end, desc = "View full Git blame" }
  -- maps.n["<Leader>gp"] = { function() require("gitsigns").preview_hunk() end, desc = "Preview Git hunk" }
  -- maps.n["<Leader>gh"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" }
  -- maps.n["<Leader>gr"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" }
  -- maps.n["<Leader>gs"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage Git hunk" }
  -- maps.n["<Leader>gS"] = { function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" }
  -- maps.n["<Leader>gu"] = { function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage Git hunk" }
  -- maps.n["<Leader>gd"] = { function() require("gitsigns").diffthis() end, desc = "View Git diff" }

  maps.n["<Leader>gb"] =
    { function() telescope.git_branches { use_file_path = true } end, desc = "Git branches" }
  maps.n["<Leader>gc"] = {
    function() telescope.git_commits { use_file_path = true } end,
    desc = "Git commits (repository)",
  }
  maps.n["<Leader>gC"] = {
    function() telescope.git_bcommits { use_file_path = true } end,
    desc = "Git commits (current file)",
  }
  maps.n["<Leader>gt"] =
    { function() telescope.git_status { use_file_path = true } end, desc = "Git status" }

  maps.n["<Leader>gg"] = {
    function()
      local term = require "FTerm"
  -- TODO: git was removed for v4 of AstroNvim... find a replacement here.
      local worktree = require("astrocore.git").file_worktree()
      local flags = worktree
          and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
        or ""
      term.scratch {
        cmd = "lazygit " .. flags,
        auto_close = true,
        on_exit = function() term.close() end,
      }
    end,
    desc = "lazygit Terminal",
  }

  -- ---

  maps.n["<Leader>h"] = { ":Alpha<cr>", desc = "Home Toggle" }

  -- TODO: enable this
  maps.n["<Leader>i"] = { function() notify "???" end, desc = "???" }

  maps.n["<Leader>j"] = { function() telescope.jumplist() end, desc = "Find Jump Point" }

  maps.n["<Leader>k"] = { function() telescope.keymaps() end, desc = "Find Key Mapping" }

  -- LSP Menu

  maps.n["<Leader>l"] = { "<Leader>l", desc = ui.get_icon("ActiveLSP", 1, true) .. "LSP Menu" }

  -- maps.n["<Leader>m"] = { desc = "" }
  maps.n["<Leader>m"] = { ":messages<cr>", desc = "Open Messages" }

  -- maps.n["<Leader>n"] = { "<cmd>enew<cr>", desc = "New File" }
  maps.n["<Leader>n"] = { ":Notifications<cr>", desc = "Open Notifications" }

  -- Obsidian Menu

  maps.n["<Leader>o"] = { function() notify "Obsidian Menu" end, desc = "Obsidian Menu" }
  maps.n["<Leader>oo"] = { function() notify "TODO" end, desc = "TODO" }

  -- Plugin Menu

  maps.n["<Leader>p"] = { "<Leader>p", desc = ui.get_icon("Package", 1, true) .. "Plugin Menu" }

  -- maps.n["<Leader>q"] = { desc = "Quit (AstroNvim)" }
  maps.n["<Leader>q"] = {
    function()
      local bufs = vim.fn.getbufinfo { buflisted = true }
      require("astrocore.buffer").close(0)
      if core.is_available "alpha-nvim" and not bufs[2] then
        require("alpha").start(true)
      end
    end,
    desc = "Close Buffer",
  }

  -- maps.n["<Leader>r"] = { desc = "" }
  maps.n["<Leader>r"] = { function() telescope.resume() end, desc = "Resume Find" }

  -- NOTE: remapped from <Leader>S to <Leader>s later in this file
  -- maps.n["<Leader>s"] = { desc = "" }

  -- maps.n["<Leader>t"] = { desc = "Terminal Menu (toggleterm)" }
  -- maps.n["<Leader>t"] = { desc = "(not using toggleterm)" }
  maps.n["<Leader>t"] =
    { function() notify "Test Menu" end, desc = ui.get_icon("TestPassed", 1, true) .. "Test Menu" }
  maps.n["<Leader>tr"] = { function() notify "do something" end, desc = "Run Tests" }

  -- UI Menu

  maps.n["<Leader>u"] = { "<Leader>u", desc = ui.get_icon("Window", 1, true) .. "UI Menu" }
  maps.n["<Leader>ut"] = { ":TransparentToggle<cr>", desc = "Toggle transparency" }

  -- ---

  maps.n["<Leader>v"] = { function() notify " ??? " end, desc = "???" }

  -- maps.n["<Leader>w"] = { desc = "Save (AstroNvim) }
  maps.n["<Leader>w"] = { ":w<cr>", desc = "Write File" }

  -- maps.n["<Leader>x"] = { desc = "" }
  -- maps.n["<Leader>x"] = { "<nop>", desc = "disabled" }
  maps.n["<Leader>x"] = { ":confirm xa<cr>", desc = "Write & Quit" }

  maps.n["<Leader>y"] = { ":ToggleWrapMode<cr>", desc = "Toggle Wrap Mode" }

  -- Fold Menu

  -- TODO: common position/fold menu (z has a ton of options :))
  maps.n["<Leader>z"] = { "<Leader>z", desc = "Fold Menu" }
  maps.n["<Leader>zz"] = { "<Leader>zz", desc = "TODO" }

  -- UPPERCASE

  -- maps.n["<Leader>A"] = { function() notify " ??? " end, desc = "!" }

  -- maps.n["<Leader>A"] = { desc = "" }
  -- maps.n["<Leader>B"] = { desc = "" }

  -- maps.n["<Leader>C"] = { desc = "" }
  helpers.removekey(maps.n, "<Leader>C") -- unmap AstroNvim's close all

  -- maps.n["<Leader>D"] = { desc = "" }
  -- maps.n["<Leader>E"] = { desc = "" }
  -- maps.n["<Leader>F"] = { desc = "" }
  -- maps.n["<Leader>G"] = { desc = "" }
  -- maps.n["<Leader>H"] = { desc = "" }
  -- maps.n["<Leader>I"] = { desc = "" }
  -- maps.n["<Leader>J"] = { desc = "" }
  -- maps.n["<Leader>K"] = { desc = "" }
  -- maps.n["<Leader>L"] = { desc = "" }
  -- maps.n["<Leader>M"] = { desc = "" }
  -- maps.n["<Leader>N"] = { desc = "" }
  maps.n["<Leader>N"] = { "<cmd>enew<cr>", desc = "New File" }

  -- maps.n["<Leader>O"] = { desc = "" }
  -- maps.n["<Leader>P"] = { desc = "" }
  -- maps.n["<Leader>Q"] = { desc = "" }
  maps.n["<Leader>Q"] = { ":confirm qa<cr>", desc = "Close All?" }

  -- maps.n["<Leader>R"] = { desc = "" }

  -- maps.n["<Leader>S"] = { desc = "Session Menu" }
  helpers.renameleader(maps.n, "S", "s")
  maps.n["<Leader>s"] = { "<Leader>s", desc = ui.get_icon("Session", 1, true) .. "Session Menu" }

  -- maps.n["<Leader>T"] = { desc = "" }
  -- maps.n["<Leader>U"] = { desc = "" }
  -- maps.n["<Leader>V"] = { desc = "" }

  -- maps.n["<Leader>W"] = { desc = "" }
  maps.n["<Leader>W"] = { ":w!<cr>", desc = "Write! File" }

  -- maps.n["<Leader>X"] = { desc = "" }
  maps.n["<Leader>X"] = { ":confirm xa!<cr>", desc = "Write! & Quit" }

  -- maps.n["<Leader>Y"] = { desc = "" }
  -- maps.n["<Leader>Z"] = { desc = "" }

  -- SYMBOLS

  maps.n["<Leader>~"] = { function() notify "~ word under cursor" end, desc = "Toggle Word Case" }
  -- maps.n["<Leader>!"] = { desc = "" }
  -- maps.n["<Leader>@"] = { desc = "" }

  -- maps.n["<Leader>`"] = { desc = "" }
  maps.n["<Leader>`"] = { function() telescope.jumplist() end, desc = "Find Jump" }

  -- Numeric keys

  -- NOTE: it's challenging/difficult to map to F1-F10 so skip for now.
  -- maps.n["<Leader>1"] = { desc = "" }
  -- maps.n["<Leader>2"] = { desc = "" }
  -- maps.n["<Leader>3"] = { desc = "" }
  -- maps.n["<Leader>4"] = { desc = "" }
  -- maps.n["<Leader>5"] = { desc = "" }
  -- maps.n["<Leader>6"] = { desc = "" }
  -- maps.n["<Leader>7"] = { desc = "" }
  -- maps.n["<Leader>8"] = { desc = "" }
  -- maps.n["<Leader>9"] = { desc = "" }
  -- maps.n["<Leader>0"] = { desc = "" }

  -- maps.n["<Leader>-"] = { desc = "" }
  maps.n["<Leader>-"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Comment Toggle",
  }
  maps.v["<Leader>-"] = {
    "<esc>:lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    desc = "Comment Toggle",
  }

  -- maps.n["<Leader>="] = { desc = "" }
  maps.n["<Leader>="] =
    { function() vim.lsp.buf.format() end, desc = "Format Buffer" }

  -- maps.n["<Leader>{"] = { desc = "" }
  -- maps.n["<Leader>}"] = { desc = "" }

  maps.n["<Leader>["] = { desc = "Previous {Obj} Menu ¹" }
  maps.n["<Leader>]"] = { desc = "Next {Obj} Menu ¹" }

  -- maps.n["<Leader>|"] = { desc = "" }
  -- maps.n["<Leader>\\"] = { function() notify "TODO - ???" end, desc = "TODO - ???" }
  maps.n["<Leader>\\"] = { "<cmd>GpChatToggle split<cr>", desc = "Toggle Chat" }

  -- maps.n["<Leader>:"] = { desc = "" }
  -- maps.n["<Leader>;"] = { desc = "" }
  -- TODO: snippet expansion
  maps.n["<Leader>;"] = { function() notify "TODO: snippets lookup?" end, desc = "Find Snippet" }

  -- NOTE: shifted
  -- maps.n["<Leader>\""]" = { desc = "" }
  maps.n['<Leader>"'] = { function() telescope.registers() end, desc = "Find Register" }

  -- maps.n["<Leader>'"] = { desc = "" }
  maps.n["<Leader>'"] = { function() telescope.marks() end, desc = "Find Mark" }

  -- maps.n["<Leader><"] = { desc = "" }
  -- maps.n["<Leader>>"] = { desc = "" }

  -- maps.n["<Leader>,"] = { desc = "" }
  maps.n["<Leader>,"] = { function() telescope.buffers() end, desc = "Find Buffer" }

  -- maps.n["<Leader>."] = { desc = "" }
  maps.n["<Leader>."] = { function() telescope.command_history() end, desc = "Command History" }

  -- maps.n["<Leader>?"] = { desc = "" }
  -- maps.n["<Leader>/"] = { desc = "Toggle Comment Line" }
  maps.n["<Leader>/"] = { function() telescope.search_history() end, desc = "Search History" }

  maps.n["<Leader><space>"] = { ":Telescope<cr>", desc = "Telescope" }

  -- --------------
  -- Extra Mappings
  -- --------------

  -- BITS & PIECES from around the net

  -- NORMAL MODE (maps.n)

  -- local selectchg = function()
  --   local cmd = "v`[" .. vim.builtin.strpart(vim.builtin.getregtype(), 0, 1) .. "`]"
  --   vim.run("normal! " .. cmd)
  -- end
  -- maps.n["gp"] = { selectchg, expr = true, desc = "Select Last Change" }

  -- Diagnostic list
  maps.n["[d"] = { ":lua vim.diagnostic.goto_prev({float = true})<cr>" }
  maps.n["]d"] = { ":lua vim.diagnostic.goto_next({float = true})<cr>" }

  -- Error list
  maps.n["[e"] = { ":lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>" }
  maps.n["]e"] = { ":lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>" }

  -- Location list
  maps.n["[l"] = { ":lprevious<cr>" }
  maps.n["]l"] = { ":lnext<cr>" }

  -- Quickfix list
  maps.n["[q"] = { ":cprevious<cr>" }
  maps.n["]q"] = { ":cnext<cr>" }

  -- Buffer list
  maps.n["]b"] = { ":bnext<cr>" }
  maps.n["[b"] = { ":bprev<cr>" }

  -- File list
  maps.n["]n"] = { ":next<cr>" }
  maps.n["[n"] = { ":prev<cr>" }

  -- yank/paste clipboard
  maps.n["gp"] = { '"+p' }
  maps.n["gP"] = { '"+P' }

  maps.n["gy"] = { '"+y' }
  maps.n["gY"] = { '"+y$' }

  -- INSERT MODE (maps.i)

  -- alternative esc
  maps.i["jj"] = { "<esc>l" }

  -- insert special characters
  maps.i["<C-v>"] = { "<C-v>", desc = "Insert Ctrl Char" }

  -- navigate display lines
  maps.i["<Down>"] = { "<esc>gja" }
  maps.i["<Up>"] = { "<esc>gka" }

  -- VISUAL MODE (maps.v)

  -- block move selected content up/down
  maps.v["J"] = { ":m '>+1<CR>gv=gv" }
  maps.v["K"] = { ":m '<-2<CR>gv=gv" }

  -- VISUAL+SELECT MODE (maps.x)

  maps.x["<Leader>p"] = { [["_dP]], desc = "Paste Over" }

  -- better indent
  maps.x["<"] = { "<gv" }
  maps.x[">"] = { ">gv" }

  -- yank/paste clipboard
  maps.x["gy"] = { '"+y' }
  maps.x["gp"] = { '"+p' }

  -- TERMINAL MODE (maps.t)

  -- ---
  -- Cleanups
  -- ---

  -- RENAMINGS / REMOVALS / REDOCUMENTATION / REORGANIZATION

  -- if not vim.tbl_isempty(lsp_mappings.v) then
  --   lsp_mappings.v["<Leader>l"] = { desc = (vim.g.icons_enabled and " " or "") .. "LSP" }
  -- end

  return maps
end

-- ---
-- Outro
-- ---

---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.mappings = enhance_maps(opts.mappings)
    end
  }
}
