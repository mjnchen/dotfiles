#!/usr/bin/env python3
"""Fetch AI news from RSS feeds and return structured JSON."""

import argparse
import json
import sys
import urllib.request
import xml.etree.ElementTree as ET
from datetime import datetime

FEEDS = {
    "smol.ai": "https://news.smol.ai/rss.xml",
    "TLDR AI": "https://tldr.tech/api/rss/ai",
    "The Rundown AI": "https://rss.beehiiv.com/feeds/2R3C6Bt5wj.xml",
}


def fetch_rss(url, timeout=30):
    req = urllib.request.Request(url, headers={"User-Agent": "ai-daily-news/1.0"})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return resp.read()


def parse_feed(xml_bytes):
    root = ET.fromstring(xml_bytes)
    items = []
    for item in root.iter("item"):
        pub_date_el = item.find("pubDate")
        pub_date = pub_date_el.text.strip() if pub_date_el is not None else None
        date_str = None
        if pub_date:
            for fmt in ("%a, %d %b %Y %H:%M:%S %z", "%a, %d %b %Y %H:%M:%S %Z"):
                try:
                    date_str = datetime.strptime(pub_date, fmt).strftime("%Y-%m-%d")
                    break
                except ValueError:
                    continue
        items.append({
            "title": (item.find("title").text or "").strip() if item.find("title") is not None else "",
            "link": (item.find("link").text or "").strip() if item.find("link") is not None else "",
            "description": (item.find("description").text or "").strip() if item.find("description") is not None else "",
            "date": date_str,
            "pubDate": pub_date,
        })
    return items


def main():
    parser = argparse.ArgumentParser(description="Fetch AI news from RSS feeds")
    parser.add_argument("--date", help="Filter by date (YYYY-MM-DD)")
    parser.add_argument("--date-range", action="store_true", help="Show available date range")
    parser.add_argument("--source", choices=list(FEEDS.keys()), default="smol.ai", help="RSS source")
    args = parser.parse_args()

    url = FEEDS[args.source]
    try:
        xml_bytes = fetch_rss(url)
    except Exception as e:
        print(json.dumps({"error": f"Failed to fetch RSS from {args.source}: {e}"}))
        sys.exit(1)

    items = parse_feed(xml_bytes)

    if args.date_range:
        dates = sorted({item["date"] for item in items if item["date"]})
        print(json.dumps({"available_dates": dates, "range": f"{dates[0]} ~ {dates[-1]}" if dates else None}))
        return

    if args.date:
        items = [item for item in items if item["date"] == args.date]

    print(json.dumps({"items": items, "count": len(items), "source": args.source}, ensure_ascii=False))


if __name__ == "__main__":
    main()
