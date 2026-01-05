# CR:UX Tree-sitter Configuration

Tree-sitter queries for CR:UX language support in Neovim.

## Files

- **highlights.scm** - Syntax highlighting rules
  - Keywords, operators, literals
  - Special CR:UX constructs (TARS, GLOBALS, $.fn)
  - Forbidden keywords highlighted as errors (var, class, new, this)

- **injections.scm** - Language injections
  - TARS blocks get JavaScript highlighting
  - $.doc template strings get markdown highlighting

- **indents.scm** - Auto-indentation rules
  - Proper indent/dedent for blocks, functions, control flow
  - TARS block handling

- **locals.scm** - Semantic scope tracking
  - Variable definitions and references
  - Function scopes
  - Parameter tracking

## Setup Checklist

Once the tree-sitter-crux grammar is ready:

1. **Update parser path** in `lua/plugins/crux.lua`:
   ```lua
   url = "path/to/tree-sitter-crux",
   ```

2. **Install the parser**:
   ```vim
   :TSInstall crux
   ```
   Or manually compile and place in `~/.local/share/nvim/site/parser/crux.so`

3. **Verify installation**:
   ```vim
   :checkhealth nvim-treesitter
   ```

4. **Test highlighting**:
   Open a `.crux` file and run:
   ```vim
   :InspectTree
   ```

## Query Refinement

The queries are based on standard JavaScript tree-sitter grammar.
You may need to adjust them based on your actual grammar structure:

- Check node names match your grammar (`tree-sitter parse file.crux`)
- Adjust field names if different (e.g., `body:`, `name:`, `property:`)
- Add CR:UX-specific nodes if you have custom grammar rules

## CR:UX-Specific Features

### TARS Blocks
```javascript
TARS: { /* JavaScript code */ }
TARS_warn: { /* suppressed */ }
```
Highlighted as JavaScript with label annotation.

### GLOBALS Declaration
```javascript
GLOBALS: foo, bar, baz;
```
Special label highlighting.

### $.fn Pattern
```javascript
$.fn($, 'name', $.doc`...`, (args) => { ... });
```
- `$` highlighted as builtin variable
- `.fn`, `.doc` as methods
- Template strings in $.doc as documentation

### Forbidden Keywords
`var`, `class`, `new`, `this` are highlighted as `@error` to make them
visually obvious.

## Debugging

If highlighting doesn't work:
1. Check parser is installed: `:echo nvim_get_runtime_file('parser/crux.so', 1)`
2. Check queries load: `:lua vim.treesitter.query.get('crux', 'highlights')`
3. Inspect tree: `:InspectTree`
4. Check for errors: `:messages`
