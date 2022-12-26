# checl if current folder have git repository
def "git is_git_folder" [] {
  test {git status}
}

# git branch name
def "git branch_name" [] {
  git branch --show-current
}

# check uncommited changes
def "git is_touched" [] {
  (git status --porcelain) != ""
}

# untracked files count
def "git untracked_count" [] {
  git status --porcelain
  | lines
  | where $it =~ '\?\? *'
  | length
}

# uncommited modified (edited, added, deleted) files count
def "git modified_count" [] {
  git status --porcelain
  | lines
  | where $it =~ 'M *' or $it =~ 'A *' or $it =~ 'D *'
  | length
}

# all comits count
def "git commits_count" [] {
  if (test {git log}) {
    git log
    | lines
    | where ($it | str starts-with "commit ")
    | length
  } else {
    0
  }
}

# check if local repository have commits which not pushed yet
def "git is_ahead" [] {
  git status
  | find ahead
  | length
  | $in > 0
}

# count of local commits which not pushed yet
def "git ahead_count" [] {
  if (git is_ahead) {
    git status
    | find ahead
    | split row " "
    | last 2
    | first
  } else {
    0
  }
}
