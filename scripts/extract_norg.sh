#!/bin/bash

NORG_FILE="$1"

QUERY="""
(ranged_tag
  (tag_name) @name
  (ranged_tag_content) @code
  (#eq? @name \"code\"))
"""

extraced_code=$(tree-sitter query --captures <(printf "%s" "$QUERY") "$NORG_FILE" | /bin/sed "s/    pattern:\s*\w*, capture:\s*\w*\s*-\s*name, start:\s*(\w*,\s*\w*),\s*end:\s(\w*,\s*\w*),\s*text:\s\`code\`//" | /bin/sed "s/    pattern:\s*\w*, capture:\s*\w*\s*-\s*code, start:\s*(\w*,\s*\w*),\s*end:\s(\w*,\s*\w*),\s*text:\s/---\n/" | awk '{ if (NR!=1) { print substr($0, 3, length($0)-5) } }' RS="---")

echo "$extraced_code"
