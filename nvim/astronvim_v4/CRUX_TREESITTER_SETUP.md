# CR:UX Tree-sitter Setup - Completed

## What's Been Prepared

All the necessary Neovim configuration for CR:UX tree-sitter support:

### 1. Plugin Configuration
**File:** `lua/plugins/crux.lua`
- Filetype detection for `.crux` files
- Tree-sitter parser registration
- Highlight and indent enabled

**TODO:** Update the parser path in line 28:
```lua
url = "~/path/to/tree-sitter-crux",  -- Change this to actual path
```

### 2. Query Files
**Location:** `queries/crux/`

- **highlights.scm** - Syntax highlighting
  - CR:UX keywords, operators, literals
  - Special constructs: JSVM, GLOBALS, $.fn, $.doc
  - Forbidden keywords as errors (var, class, new, this)

- **injections.scm** - Embedded language highlighting
  - JSVM blocks → JavaScript highlighting
  - $.doc templates → Markdown highlighting

- **indents.scm** - Auto-indentation
  - Blocks, functions, control flow
  - JSVM block handling

- **locals.scm** - Semantic analysis
  - Variable definitions/references
  - Function scopes
  - Parameter tracking

- **test-highlighting.crux** - Test file for validation

- **README.md** - Documentation

## Next Steps (Once Grammar is Ready)

### 1. Update Parser Path
Edit `lua/plugins/crux.lua` line 28 with actual grammar location.

### 2. Install Parser

**Option A: Via nvim-treesitter**
```vim
:TSInstall crux
```

**Option B: Manual compile**
```bash
cd /path/to/tree-sitter-crux
tree-sitter generate
gcc -o crux.so -shared src/parser.c -I./src -Os -fPIC
mkdir -p ~/.local/share/nvim/site/parser
cp crux.so ~/.local/share/nvim/site/parser/
```

### 3. Verify Setup
```vim
:checkhealth nvim-treesitter
```

### 4. Test Highlighting
Open `queries/crux/test-highlighting.crux`:
```vim
nvim queries/crux/test-highlighting.crux
:InspectTree
```

Should see:
- Keywords highlighted (const, let, return, if, etc.)
- JSVM labels in special color
- $.fn and $.doc patterns recognized
- var/class/new/this shown as errors
- JSVM blocks with JavaScript highlighting
- Proper indentation on newlines

### 5. Adjust Queries (If Needed)

If your grammar uses different node names:
```bash
tree-sitter parse file.crux  # See actual node structure
```

Then update query files to match actual node names.

## Integration with Existing Setup

- **TARS diagnostics** - Already working via null-ls
- **Syntax highlighting** - Will use tree-sitter (replaces JavaScript fallback)
- **Indentation** - Will use tree-sitter indents.scm
- **Folding** - Tree-sitter provides structural folding

## Debugging Tips

**Parser not loading:**
```vim
:lua print(vim.inspect(vim.treesitter.language.get_lang('crux')))
:echo nvim_get_runtime_file('parser/crux.so', 1)
```

**Queries not working:**
```vim
:lua vim.treesitter.query.get('crux', 'highlights')
:lua vim.treesitter.query.get('crux', 'injections')
```

**See parse tree:**
```vim
:InspectTree
```

**Check errors:**
```vim
:messages
:checkhealth nvim-treesitter
```

## File Locations

All in `~/.dotfiles/nvim/astronvim_v4/`:
```
lua/plugins/crux.lua              - Parser registration
queries/crux/highlights.scm       - Syntax colors
queries/crux/injections.scm       - Embedded languages
queries/crux/indents.scm          - Auto-indent
queries/crux/locals.scm           - Scope tracking
queries/crux/test-highlighting.crux - Test file
queries/crux/README.md            - Query documentation
```

## Ready to Use

Once you:
1. Update parser path in crux.lua
2. Install/compile the parser
3. Restart Neovim

Everything should work automatically for `.crux` files.
