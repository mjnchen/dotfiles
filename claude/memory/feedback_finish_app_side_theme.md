---
name: feedback-finish-app-side-theme
description: "On theme switches, finish and verify GUI-app changes (Claude app, Codex) myself instead of handing steps back"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 16b1bcb6-4a9f-445a-a8f0-0c7a001e0016
  modified: 2026-11-27T06:19:29.063Z
---

When switching themes, the user expects me to make the change take effect in the Claude desktop app too, not just edit settings and hand back "restart / start a new session". On 2026-11-26 I flipped the mod in settings.json, but the app kept the old Tokyo Night colors until the user did it by hand, and they were frustrated.

**Why:** The user asked for "everything including claude app" and "don't make mistakes"; leaving the last step undone counted as a miss.

**How to apply:** The `<theme>@dotfiles` mods only paint on `session.start` of a session running *inside the desktop app*; a headless `claude -p` session does not repaint the app. After flipping the mod, either drive the app (Settings → Appearance → Code dropdowns, or start a new session there) with the user's OK, or say up front that this one step must be done in the app. Then verify with a window screenshot (`screencapture -x -o -l <windowid>`; window id via a CGWindowListCopyWindowInfo swift snippet) before calling it done. Related: [[project_dotfiles]]
