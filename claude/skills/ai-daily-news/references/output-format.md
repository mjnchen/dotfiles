# Output Format

Structured markdown output template for AI daily news.

## Template

```markdown
# AI Daily · {YYYY}年{M}月{D}日

## 核心摘要

- {takeaway 1}
- {takeaway 2}
- {takeaway 3}

## 模型发布

### {Model Name}
{Summary paragraph}
[原文链接]({url})

## 产品动态

### {Product Name}
{Summary paragraph}
[原文链接]({url})

## 研究论文

### {Paper Title}
{Summary paragraph}
[原文链接]({url})

## 工具框架

### {Tool Name}
{Summary paragraph}
[原文链接]({url})

## 融资并购

### {Company / Deal}
{Summary paragraph}
[原文链接]({url})

## 行业事件

### {Event}
{Summary paragraph}
[原文链接]({url})

## 关键词

#{keyword1} #{keyword2} #{keyword3} #{keyword4} #{keyword5}

---
数据来源: smol.ai
```

## Rules

- Omit any category section that has no items for the day.
- Each category item should have a heading, a 1-2 sentence summary, and a source link.
- Core summary should contain 3-5 one-sentence takeaways.
- Keywords should list 5-10 notable companies, products, or technologies mentioned.
- Date in title uses Chinese format: `2026年1月13日`.
