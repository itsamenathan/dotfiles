#!/bin/bash
# statusLine command for Claude Code: simple emoji-labeled single line.

input=$(cat)

model=$(jq -r '.model.display_name // "?"' <<<"$input")
cwd=$(jq -r '.workspace.current_dir // .cwd // "."' <<<"$input")
ctx_pct=$(jq -r '.context_window.used_percentage // empty' <<<"$input")
cost=$(jq -r '.cost.total_cost_usd // 0' <<<"$input")
dur_ms=$(jq -r '.cost.total_duration_ms // 0' <<<"$input")
added=$(jq -r '.cost.total_lines_added // 0' <<<"$input")
removed=$(jq -r '.cost.total_lines_removed // 0' <<<"$input")

fmt_duration() {
  local ms=$1 s=$(( $1 / 1000 ))
  if (( s < 60 )); then
    printf '%ds' "$s"
  elif (( s < 3600 )); then
    printf '%dm%ds' "$((s/60))" "$((s%60))"
  else
    printf '%dh%dm' "$((s/3600))" "$((s%3600/60))"
  fi
}

parts=("🤖 $model")

[[ -n "$ctx_pct" ]] && parts+=("🧠 ${ctx_pct}%")

parts+=("💰 \$$(awk -v c="$cost" 'BEGIN{printf "%.2f", c}')")
parts+=("⏱️ $(fmt_duration "$dur_ms")")
parts+=("📂 ${cwd/#$HOME/~}")

if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  gitdir=$(git -C "$cwd" rev-parse --git-dir 2>/dev/null)
  commondir=$(git -C "$cwd" rev-parse --git-common-dir 2>/dev/null)
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
  [[ -z "$branch" ]] && branch=$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  dirty=""
  [[ -n "$(git -C "$cwd" status --porcelain 2>/dev/null)" ]] && dirty="*"

  if [[ -n "$gitdir" && "$gitdir" != "$commondir" ]]; then
    project=$(basename "$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null)")
    parts+=("🌳 $project")
  fi
  parts+=("🌿 ${branch}${dirty} +${added} -${removed}")
fi

line=""
for p in "${parts[@]}"; do
  if [[ -z "$line" ]]; then line="$p"; else line="$line | $p"; fi
done
printf '%s\n' "$line"
