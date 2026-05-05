# Claude Code Setup

## Plugins

### Official marketplace (`anthropics/claude-plugins-official`)

```sh
claude plugins install xlsx
claude plugins install pdf
claude plugins install pptx
claude plugins install docx
claude plugins install mcp-builder
claude plugins install skill-creator
claude plugins install hookify
claude plugins install claude-code-setup
claude plugins install pr-review-toolkit
claude plugins install superpowers
```

## Plugin roles

| Plugin | Role |
|---|---|
| `pr-review-toolkit` | PR review — 6 focused sub-agents for quick feedback |
| `superpowers` | Brainstorming, TDD, debugging, structured dev workflows |
| `hookify` | Create Claude Code hooks from conversation patterns |
| `claude-code-setup` | Analyze codebase and recommend hooks, skills, MCP servers |
| `skill-creator` | Create and eval custom skills |
| `mcp-builder` | Build MCP servers to integrate external APIs |
| `xlsx` / `pdf` / `pptx` / `docx` | File format handling |
