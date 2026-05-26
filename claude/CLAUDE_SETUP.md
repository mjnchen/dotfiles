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

## Third-party skills (MCPmarket)

Install by copying the skill file to `~/.claude/skills/`:

| Skill | Source | Role |
|---|---|---|
| `ai-daily-news` | [mcpmarket.com](https://mcpmarket.com/tools/skills/ai-daily-news-assistant) | Fetch AI news from smol.ai RSS, summarize and categorize, optionally generate HTML pages or shareable card images |

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

## CLAUDE.md references

The Karpathy 12 Rules in `CLAUDE.md` are adapted from:

- [Karpathy's X post](https://x.com/karpathy/status/2015883857489522876)
- [Reddit discussion (r/AskVibeCoders)](https://www.reddit.com/r/AskVibecoders/comments/1ta7yr8/karpathys_claudemd_cuts_claude_mistakes_to_11/)
- [Gist with full CLAUDE.md](https://gist.github.com/Planxnx/64b173bacf2c8c43435c4333d0b9bd94)
