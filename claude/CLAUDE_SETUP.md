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

### Third-party marketplaces

**Compound Engineering** (`EveryInc/compound-engineering-plugin`) — requires adding the marketplace first:

```sh
claude plugins marketplace add EveryInc/compound-engineering-plugin
claude plugins install compound-engineering@compound-engineering-plugin
```

## Plugin roles

| Plugin | Role |
|---|---|
| `compound-engineering` | Thorough code review — 12 parallel sub-agents, captures learnings across sessions |
| `pr-review-toolkit` | Lighter PR review — 6 focused sub-agents for quick feedback |
| `superpowers` | Brainstorming, TDD, debugging, structured dev workflows |
| `hookify` | Create Claude Code hooks from conversation patterns |
| `claude-code-setup` | Analyze codebase and recommend hooks, skills, MCP servers |
| `skill-creator` | Create and eval custom skills |
| `mcp-builder` | Build MCP servers to integrate external APIs |
| `xlsx` / `pdf` / `pptx` / `docx` | File format handling |
