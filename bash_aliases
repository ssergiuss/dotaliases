# Bash
alias l='ls -ahl'
alias v='vimr'
alias vd='vimr --cwd'
function webprod-log {
  local logfile="${1:-app_debug.log}"
  nvim "scp://webprod//var/partfiniti_production/logs/${logfile}"
}

# Git
alias g='git log --oneline --decorate -10; printf "\n"; git status -sb'
alias ga='git add --all'
alias gb='git branch'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gcmnv='git commit --no-verify -m'
alias gd='git diff --color-words'
alias gdc='git diff --cached -w'
alias gdv='git diff'
alias gdw='git diff --no-ext-diff --word-diff'
alias gf='git fetch'
alias gl='git log --oneline --decorate'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpr='git pull --rebase'
# Git prune remote branches
alias gprb='git remote update origin --prune'
alias gpp='git pull --rebase && git push'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase -i'
alias grs='git rebase --skip'
alias gs='git stash'
alias gsl='git stash list'
alias gsp='git stash pop'
alias gss='git stash save'
alias gt='git tag'
alias gw='git worktree list'
function gwa {
  local branch="$1"
  local prefix="$(basename "$PWD")"
  if [[ -z "$branch" ]]; then
    echo "error: branch name required"
    return 1
  fi
  if [[ "$branch" =~ ^(master|main|staging|develop|development)$ ]]; then
    echo "error: refusing to create worktree for protected branch '$branch'"
    return 1
  fi
  git worktree add "../${prefix}-${branch}" "$branch" && cd "../${prefix}-${branch}"
}
function gwab {
  local branch="$1"
  local prefix="$(basename "$PWD")"
  if [[ -z "$branch" ]]; then
    echo "error: branch name required"
    return 1
  fi
  if [[ "$branch" =~ ^(master|main|staging|develop|development)$ ]]; then
    echo "error: refusing to create worktree for protected branch '$branch'"
    return 1
  fi
  git worktree add -b "$branch" "../${prefix}-${branch}" && cd "../${prefix}-${branch}"
}
# Fetch remote branch and rebase current branch on it (worktree-safe)
function gru {
  local branch="${1:-staging}"
  git fetch origin "$branch" && git rebase "origin/$branch"
}
alias gwp='git worktree prune'
alias gwr='git worktree remove'
# Git update
alias gupd='CURR_BRANCH=$(git rev-parse --abbrev-ref HEAD); \
for BRANCH in staging master; do \
  if git show-ref --verify --quiet refs/heads/$BRANCH; then \
    git checkout $BRANCH; git pull --rebase; \
  else \
    echo "Branch $BRANCH does not exist."; \
  fi; \
done; \
git checkout $CURR_BRANCH;\
git remote update origin --prune'
