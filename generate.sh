#!/usr/bin/env bash
# generate.sh — 从 core-template 生成各平台 skill 文件（对话式菜单）

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/core-template"
OUTPUT_DIR="$SCRIPT_DIR/_internal/agent-skills"
VERSION="$(date +%Y-%m-%d)"

DRY_RUN=false
DO_INSTALL=false
INSTALL_SCOPE="user"   # user = 用户级，project = 项目级
FILTER=""
LANG_SUFFIX=""   # 空 = 英文，.zh = 中文

# ─────────────────────────────────────────────
# 非交互 CLI 参数解析
# ─────────────────────────────────────────────
usage() {
  cat <<EOF
用法: generate.sh [选项]

选项:
  --platform <id>   平台：all | copilot | claude | codex | codebuddy  (默认: all)
  --lang <lang>     语言：en | zh  (默认: en)
  --install <scope> 安装范围：user | project  (默认: 不安装)
  --dry-run         仅预览，不写入文件
  --help            显示此帮助

示例:
  generate.sh --platform claude --lang zh --install user
  generate.sh --platform copilot --dry-run
EOF
  exit 0
}

NON_INTERACTIVE=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h)     usage ;;
    --dry-run)     DRY_RUN=true; NON_INTERACTIVE=true; shift ;;
    --platform)    FILTER="$2"; [[ "$FILTER" == "all" ]] && FILTER=""; NON_INTERACTIVE=true; shift 2 ;;
    --lang)        [[ "$2" == "zh" ]] && LANG_SUFFIX=".zh" || LANG_SUFFIX=""; NON_INTERACTIVE=true; shift 2 ;;
    --install)     DO_INSTALL=true; INSTALL_SCOPE="$2"; NON_INTERACTIVE=true; shift 2 ;;
    *) echo -e "未知参数: $1\n"; usage ;;
  esac
done

if $NON_INTERACTIVE; then
  mkdir -p "$OUTPUT_DIR"
fi

# ─────────────────────────────────────────────
# 颜色 & 样式
# ─────────────────────────────────────────────
BOLD="\033[1m"
DIM="\033[2m"
RESET="\033[0m"
GREEN="\033[0;32m"
CYAN="\033[0;36m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"
MAGENTA="\033[0;35m"

ok()   { echo -e "  ${GREEN}✓${RESET}  $*"; }
info() { echo -e "  ${CYAN}ℹ${RESET}  $*"; }
warn() { echo -e "  ${YELLOW}⚠${RESET}  $*"; }
step() { echo -e "\n${BOLD}${BLUE}  $*${RESET}"; }
dry()  { echo -e "  ${DIM}[dry]${RESET} $*"; }

separator() {
  echo -e "\n${DIM}  ────────────────────────────────────${RESET}"
}

ask() {
  local var="$1"
  local prompt="$2"
  echo -e ""
  printf "  ${BOLD}❯${RESET} ${prompt} "
  read -r "$var" < /dev/tty
}

# ─────────────────────────────────────────────
# 非交互模式：跳过问答直接执行
# ─────────────────────────────────────────────
if $NON_INTERACTIVE; then
  # 跳过所有交互步骤，直接跳到生成
  true
fi

# ─────────────────────────────────────────────
# 头部 Banner
# ─────────────────────────────────────────────
print_header() {
  if [[ -t 1 && -n "${TERM:-}" ]]; then clear; fi
  echo ""
  echo -e "  ${BOLD}${CYAN}╔══════════════════════════════════════════╗${RESET}"
  echo -e "  ${BOLD}${CYAN}║${RESET}  ${BOLD}🛠  Agent Skill 生成器${RESET}  ${DIM}v${VERSION}${RESET}  ${BOLD}${CYAN}║${RESET}"
  echo -e "  ${BOLD}${CYAN}╚══════════════════════════════════════════╝${RESET}"
  echo ""
}
$NON_INTERACTIVE || print_header

# ─────────────────────────────────────────────
# 步骤 1 — 语言（非交互模式跳过）
# ─────────────────────────────────────────────
if $NON_INTERACTIVE; then
  true
else
separator
step "步骤 1 / 4  —  🌐  选择语言"
echo ""
echo -e "    ${BOLD}1)${RESET}  🇺🇸  English（英文）"
echo -e "    ${BOLD}2)${RESET}  🇨🇳  中文"
echo -e "    ${DIM}0)  退出${RESET}"

ask lang_choice "请输入编号 [0-2]："
case "$lang_choice" in
  0) echo -e "\n  ${DIM}已退出。${RESET}\n"; exit 0 ;;
  1) LANG_SUFFIX="" ;;
  2) LANG_SUFFIX=".zh" ;;
  *)
    echo -e "\n  ${RED}✗${RESET}  无效选项，退出。\n"
    exit 1 ;;
esac
fi  # end non-interactive skip for step 1

# ─────────────────────────────────────────────
# 步骤 2 — 平台（非交互模式跳过）
# ─────────────────────────────────────────────
if $NON_INTERACTIVE; then
  true
else
print_header
separator
step "步骤 2 / 4  —  🤖  选择平台"
echo ""
echo -e "    ${BOLD}1)${RESET}  🌐  全部平台  ${DIM}(copilot + claude + codex + codebuddy)${RESET}"
echo -e "    ${BOLD}2)${RESET}  🐙  GitHub Copilot"
echo -e "    ${BOLD}3)${RESET}  🔶  Claude Code"
echo -e "    ${BOLD}4)${RESET}  ✦   Codex"
echo -e "    ${BOLD}5)${RESET}  💻  CodeBuddy  ${DIM}(固定使用中文模板，不受语言选择影响)${RESET}"
echo -e "    ${DIM}0)  退出${RESET}"

ask platform_choice "请输入编号 [0-5]："
case "$platform_choice" in
  0) echo -e "\n  ${DIM}已退出。${RESET}\n"; exit 0 ;;
  1) FILTER="" ;;
  2) FILTER="copilot" ;;
  3) FILTER="claude" ;;
  4) FILTER="codex" ;;
  5) FILTER="codebuddy" ;;
  *)
    echo -e "\n  ${RED}✗${RESET}  无效选项，退出。\n"
    exit 1 ;;
esac
fi  # end non-interactive skip for step 2

# ─────────────────────────────────────────────
# 步骤 3 — 模式（非交互模式跳过）
# ─────────────────────────────────────────────
if $NON_INTERACTIVE; then
  true
else
print_header
separator
step "步骤 3 / 4  —  ⚙️   选择生成模式"
echo ""
echo -e "    ${BOLD}1)${RESET}  ✏️   正常生成  ${DIM}(写入文件)${RESET}"
echo -e "    ${BOLD}2)${RESET}  🔍  ${YELLOW}Dry-run 预览${RESET}  ${DIM}(只展示变更，不写文件)${RESET}"
echo -e "    ${DIM}0)  退出${RESET}"

ask mode_choice "请输入编号 [0-2]："
case "$mode_choice" in
  0) echo -e "\n  ${DIM}已退出。${RESET}\n"; exit 0 ;;
  1) DRY_RUN=false ;;
  2) DRY_RUN=true ;;
  *)
    echo -e "\n  ${RED}✗${RESET}  无效选项，退出。\n"
    exit 1 ;;
esac
fi  # end non-interactive skip for step 3

# ─────────────────────────────────────────────
# 步骤 4 — 安装（dry-run 时跳过，非交互模式跳过）
# ─────────────────────────────────────────────
if ! $DRY_RUN && ! $NON_INTERACTIVE; then
  print_header
  separator
  step "步骤 4 / 4  —  📦  安装目标"
  echo ""
  echo -e "    ${BOLD}1)${RESET}  📁  仅生成到 _internal/agent-skills/  ${DIM}(不安装)${RESET}"
  echo -e "    ${BOLD}2)${RESET}  🏠  安装到${BOLD}用户级${RESET}目录  ${DIM}(~/.{platform}/skills/，全局生效)${RESET}"
  echo -e "    ${BOLD}3)${RESET}  📂  安装到${BOLD}项目级${RESET}目录  ${DIM}(当前目录 .{platform}/skills/)${RESET}"
  echo -e "    ${DIM}0)  退出${RESET}"

  ask install_choice "请输入编号 [0-3]："
  case "$install_choice" in
    0) echo -e "\n  ${DIM}已退出。${RESET}\n"; exit 0 ;;
    1) DO_INSTALL=false ;;
    2) DO_INSTALL=true; INSTALL_SCOPE="user" ;;
    3) DO_INSTALL=true; INSTALL_SCOPE="project" ;;
    *)
      echo -e "\n  ${RED}✗${RESET}  无效选项，退出。\n"
      exit 1 ;;
  esac
fi

# ─────────────────────────────────────────────
# 确认摘要（非交互模式跳过）
# ─────────────────────────────────────────────
if ! $NON_INTERACTIVE; then
print_header
separator
echo ""
echo -e "  ${BOLD}📋  执行摘要${RESET}"
echo ""
_lang_label=$( [[ -z "$LANG_SUFFIX" ]] && echo "English" || echo "中文" )
_platform_label="${FILTER:-全部（copilot + claude + codex + codebuddy）}"

if $DRY_RUN; then
  _mode_label="${YELLOW}Dry-run（预览）${RESET}"
  _install_label="${DIM}跳过（dry-run）${RESET}"
else
  _mode_label="正常生成"
  if $DO_INSTALL; then
    _install_label="是（${INSTALL_SCOPE} 级）"
  else
    _install_label="否"
  fi
fi

echo -e "    ${DIM}🌐  语言   ${RESET}${BOLD}${_lang_label}${RESET}"
echo -e "    ${DIM}🤖  平台   ${RESET}${BOLD}${_platform_label}${RESET}"
echo -e "    ${DIM}⚙️   模式   ${RESET}${BOLD}$(echo -e "${_mode_label}")${RESET}"
echo -e "    ${DIM}📦  安装   ${RESET}${BOLD}$(echo -e "${_install_label}")${RESET}"
echo ""

ask confirm "确认执行？[y/N]："
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo -e "\n  ${DIM}已取消。${RESET}\n"
  exit 0
fi
fi  # end non-interactive skip for summary

separator
echo ""
if $DRY_RUN; then
  echo -e "  ${YELLOW}▶ DRY-RUN 模式 — 只预览，不写入任何文件${RESET}\n"
fi

# ─────────────────────────────────────────────
# 写文件（dry-run 时只 diff 预览）
# ─────────────────────────────────────────────
write_file() {
  local dest="$1"
  local content="$2"

  if $DRY_RUN; then
    if [[ -f "$dest" ]]; then
      echo -e "  ${DIM}[diff]${RESET} $dest"
      diff <(cat "$dest") <(echo "$content") | head -30 || true
    else
      dry "${CYAN}[new]${RESET} $dest"
      echo "$content" | head -10
      echo -e "  ${DIM}...${RESET}"
    fi
  else
    echo "$content" > "$dest"
  fi
}

# ─────────────────────────────────────────────
# 生成单个平台的 full + lite skill
# ─────────────────────────────────────────────
generate_platform() {
  local id="$1"
  local name="$2"
  local config_file="$3"
  local config_header="$4"
  local skill_full="$5"
  local skill_lite="$6"
  local template_lang_suffix="${7:-$LANG_SUFFIX}"

  [[ -n "$FILTER" && "$FILTER" != "$id" ]] && return 0

  echo -e "  ${BOLD}${MAGENTA}→${RESET} ${BOLD}$id${RESET}  ${DIM}($name)${RESET}"

  local out_full="$OUTPUT_DIR/$id/$skill_full"
  local out_lite="$OUTPUT_DIR/$id/$skill_lite"

  $DRY_RUN || mkdir -p "$out_full/references" "$out_lite"

  # 选择模板（有平台专用版优先使用，否则回退到通用版）
  local full_tpl="$TEMPLATE_DIR/workflow-full${template_lang_suffix}.md.template"
  local lite_tpl="$TEMPLATE_DIR/workflow-lite${template_lang_suffix}.md.template"
  [[ -f "$TEMPLATE_DIR/workflow-full${template_lang_suffix}.${id}.md.template" ]] && \
    full_tpl="$TEMPLATE_DIR/workflow-full${template_lang_suffix}.${id}.md.template"
  [[ -f "$TEMPLATE_DIR/workflow-lite${template_lang_suffix}.${id}.md.template" ]] && \
    lite_tpl="$TEMPLATE_DIR/workflow-lite${template_lang_suffix}.${id}.md.template"

  # Full SKILL.md
  local full_content
  full_content="$(sed \
    -e "s|{{PLATFORM_NAME}}|$name|g" \
    -e "s|{{CONFIG_FILE}}|$config_file|g" \
    -e "s|{{CONFIG_HEADER}}|$config_header|g" \
    -e "s|{{SKILL_FULL}}|$skill_full|g" \
    -e "s|{{SKILL_LITE}}|$skill_lite|g" \
    -e "s|{{VERSION}}|$VERSION|g" \
    "$full_tpl")"
  write_file "$out_full/SKILL.md" "$full_content"

  # Lite SKILL.md
  local lite_content
  lite_content="$(sed \
    -e "s|{{PLATFORM_NAME}}|$name|g" \
    -e "s|{{CONFIG_FILE}}|$config_file|g" \
    -e "s|{{CONFIG_HEADER}}|$config_header|g" \
    -e "s|{{SKILL_FULL}}|$skill_full|g" \
    -e "s|{{SKILL_LITE}}|$skill_lite|g" \
    -e "s|{{VERSION}}|$VERSION|g" \
    "$lite_tpl")"
  write_file "$out_lite/SKILL.md" "$lite_content"

  # references（只有 full 版需要）
  if $DRY_RUN; then
    dry "references/ → $out_full/references/"
  else
    cp "$TEMPLATE_DIR/references/build-plan-template.md" "$out_full/references/"
    cp "$TEMPLATE_DIR/references/decisions-template.md"  "$out_full/references/"
  fi

  ok "📄  ${skill_full}/SKILL.md"
  ok "📄  ${skill_lite}/SKILL.md"
  ok "📁  references/ synced"
  echo ""
}

# ─────────────────────────────────────────────
# 安装到本机 AI 平台目录
# ─────────────────────────────────────────────
install_skills() {
  if [[ "$INSTALL_SCOPE" == "project" ]]; then
    echo -e "\n  ${BOLD}安装到项目级${RESET}  ${DIM}$PWD/${RESET}\n"
    local copilot_dir="$PWD/.github/skills"
    local claude_dir="$PWD/.claude/skills"
    local codex_dir="$PWD/.agents/skills"
    local codebuddy_dir="$PWD/.codebuddy/skills"
  else
    echo -e "\n  ${BOLD}安装到用户级${RESET}  ${DIM}~/${RESET}\n"
    local copilot_dir="$HOME/.copilot/skills"
    local claude_dir="$HOME/.claude/skills"
    local codex_dir="$HOME/.agents/skills"
    local codebuddy_dir="$HOME/.codebuddy/skills"
  fi

  if [[ -z "$FILTER" || "$FILTER" == "copilot" ]]; then
    if $DRY_RUN; then dry "copilot → $copilot_dir/"; else
      if [[ ! -d "$OUTPUT_DIR/copilot/copilot-native-project-workflow" ]]; then
        warn "copilot 目录未生成，跳过安装。请先运行正常生成。"
      else
        mkdir -p "$copilot_dir"
        cp -r "$OUTPUT_DIR/copilot/copilot-native-project-workflow"      "$copilot_dir/"
        cp -r "$OUTPUT_DIR/copilot/copilot-native-lite-project-workflow"  "$copilot_dir/"
        ok "copilot   ${DIM}→ $copilot_dir/${RESET}"
        info "请在 VS Code 中执行 ${BOLD}Developer: Reload Window${RESET} 使 Copilot skill 生效"
      fi
    fi
  fi

  if [[ -z "$FILTER" || "$FILTER" == "claude" ]]; then
    if $DRY_RUN; then dry "claude → $claude_dir/"; else
      if [[ ! -d "$OUTPUT_DIR/claude/claude-native-project-workflow" ]]; then
        warn "claude 目录未生成，跳过安装。请先运行正常生成。"
      else
        mkdir -p "$claude_dir"
        cp -r "$OUTPUT_DIR/claude/claude-native-project-workflow"      "$claude_dir/"
        cp -r "$OUTPUT_DIR/claude/claude-native-lite-project-workflow"  "$claude_dir/"
        ok "claude    ${DIM}→ $claude_dir/${RESET}"
        info "请重启 Claude Code（或执行 ${BOLD}/reload${RESET}）使 skill 生效"
      fi
    fi
  fi

  if [[ -z "$FILTER" || "$FILTER" == "codex" ]]; then
    if $DRY_RUN; then dry "codex → $codex_dir/"; else
      if [[ ! -d "$OUTPUT_DIR/codex/codex-native-project-workflow" ]]; then
        warn "codex 目录未生成，跳过安装。请先运行正常生成。"
      else
        mkdir -p "$codex_dir"
        cp -r "$OUTPUT_DIR/codex/codex-native-project-workflow"      "$codex_dir/"
        cp -r "$OUTPUT_DIR/codex/codex-native-lite-project-workflow"  "$codex_dir/"
        ok "codex     ${DIM}→ $codex_dir/${RESET}"
        info "请重新打开终端或重启 Codex 使 skill 生效"
      fi
    fi
  fi

  if [[ -z "$FILTER" || "$FILTER" == "codebuddy" ]]; then
    if $DRY_RUN; then dry "codebuddy → $codebuddy_dir/"; else
      if [[ ! -d "$OUTPUT_DIR/codebuddy/codebuddy-native-project-workflow" ]]; then
        warn "codebuddy 目录未生成，跳过安装。请先运行正常生成。"
      else
        mkdir -p "$codebuddy_dir"
        cp -r "$OUTPUT_DIR/codebuddy/codebuddy-native-project-workflow"      "$codebuddy_dir/"
        cp -r "$OUTPUT_DIR/codebuddy/codebuddy-native-lite-project-workflow"  "$codebuddy_dir/"
        ok "codebuddy ${DIM}→ $codebuddy_dir/${RESET}"
        info "请重启 CodeBuddy 插件使 skill 生效"
      fi
    fi
  fi
}

# ─────────────────────────────────────────────
# 执行生成
# ─────────────────────────────────────────────
generate_platform \
  "copilot" "GitHub Copilot" \
  ".github/copilot-instructions.md" "# Copilot Instructions" \
  "copilot-native-project-workflow" "copilot-native-lite-project-workflow"

generate_platform \
  "claude" "Claude Code" \
  "CLAUDE.md" "# CLAUDE.md" \
  "claude-native-project-workflow" "claude-native-lite-project-workflow"

generate_platform \
  "codex" "Codex" \
  "AGENTS.md" "# AGENTS.md" \
  "codex-native-project-workflow" "codex-native-lite-project-workflow"

if [[ -z "$FILTER" || "$FILTER" == "codebuddy" ]]; then
  [[ -n "$LANG_SUFFIX" ]] || warn "CodeBuddy 固定使用中文模板，语言选择（English）对此平台不生效"
fi
generate_platform \
  "codebuddy" "CodeBuddy" \
  "CODEBUDDY.md" "# CODEBUDDY.md" \
  "codebuddy-native-project-workflow" "codebuddy-native-lite-project-workflow" \
  ".zh"

# ─────────────────────────────────────────────
# 安装（可选）
# ─────────────────────────────────────────────
$DO_INSTALL && install_skills

# ─────────────────────────────────────────────
# 安装后清理（可选）
# ─────────────────────────────────────────────
if $DO_INSTALL && ! $DRY_RUN; then
  separator
  ask cleanup_choice "是否删除 core-template/ 和 generate.sh？[y/N]："
  if [[ "$cleanup_choice" == "y" || "$cleanup_choice" == "Y" ]]; then
    rm -rf "$TEMPLATE_DIR"
    rm -f "$SCRIPT_DIR/generate.sh"
    ok "已删除 core-template/ 和 generate.sh"
  else
    info "已跳过，源文件保留"
  fi
fi

# ─────────────────────────────────────────────
# 完成
# ─────────────────────────────────────────────
separator
echo ""
if $DRY_RUN; then
  echo -e "  ${YELLOW}🔍  Dry-run 完成${RESET} — 未写入任何文件"
  info "重新运行脚本并选择「正常生成」以实际写入"
else
  # 计算实际生成的平台数量
  _platforms=()
  [[ -z "$FILTER" || "$FILTER" == "copilot"   ]] && _platforms+=(copilot)
  [[ -z "$FILTER" || "$FILTER" == "claude"    ]] && _platforms+=(claude)
  [[ -z "$FILTER" || "$FILTER" == "codex"     ]] && _platforms+=(codex)
  [[ -z "$FILTER" || "$FILTER" == "codebuddy" ]] && _platforms+=(codebuddy)
  _pcount=${#_platforms[@]}
  _count=$(( _pcount * 2 ))
  echo -e "  ${GREEN}${BOLD}🎉  完成！${RESET}  ${DIM}版本 ${VERSION} · ${_count} 个 SKILL.md + ${_pcount} 套 references/${RESET}"
fi
echo ""
