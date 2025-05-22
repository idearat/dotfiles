# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a heavily customized AstroNvim v4 configuration built on Lazy.nvim. The configuration follows a modular architecture:

- **Entry point**: `init.lua` → `lua/lazy_setup.lua` 
- **Core configs**: `lua/community.lua`, `lua/autocmds.lua`, `lua/helpers.lua`, `lua/polish.lua`
- **Plugin configs**: `lua/plugins/` directory with individual plugin configurations
- **Specialized configs**: `after/ftplugin/` for filetype-specific settings

## Key Architecture Components

### Plugin Organization
- **AstroNvim core plugins**: `astrocore.lua`, `astrolsp.lua`, `astroui.lua`
- **Mappings system**: `mappings.lua` (900+ lines of comprehensive key mappings with mnemonic organization)
- **AI integration**: `ai.lua` (currently Codeium, with custom completion handling in `user/completion_accept.lua`)
- **External tools**: Terminal helpers for LazyGit, LazyDocker, LazyNpm in `helpers.lua`

### Configuration Flow
1. `init.lua` loads lazy setup
2. `lazy_setup.lua` imports AstroNvim core, community packs, and user plugins
3. Plugin configs in `lua/plugins/` are auto-loaded by file name
4. `polish.lua` applies final customizations

## Development Commands

### Linting
```bash
# Lua linting (Selene configured in selene.toml)
selene lua/
```

### Plugin Management
- Uses Lazy.nvim - plugins auto-update on nightly builds
- Configuration files automatically trigger lazy loading
- Run `:Lazy` in Neovim to manage plugins

## Key Customizations

### Mapping System
- Comprehensive key documentation with descriptions for every mapping
- Leader key: Space (global), Comma (local leader)
- Footnote system (¹²³) indicates enhancement levels
- Extensive Telescope integration for fuzzy finding

### AI Integration
- Codeium configured as primary AI completion
- Custom completion acceptance logic that clears suggestions on mode changes
- Alternative Copilot configurations available but commented

### UI/UX
- Rose Pine theme with transparency support
- Folding completely disabled across all file types
- Focus modes via ZenMode and Twilight
- Git branch-aware session management

## Important Files to Understand

- `lua/plugins/mappings.lua` - Core of the user experience, documents every key
- `lua/plugins/ai.lua` - AI completion setup and configuration
- `lua/helpers.lua` - Terminal application integration
- `lua/polish.lua` - Final configuration and AI completion handling
- `user/completion_accept.lua` - Custom AI suggestion management

## Configuration Philosophy

This setup prioritizes:
- Comprehensive key mapping documentation
- External tool integration (Git, Docker, NPM via terminal UIs)
- AI-assisted development workflow
- Modular, maintainable configuration structure
- Performance optimization with lazy loading