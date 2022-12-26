def "git is_git_folder" [] {
  test {git status}
}

def "git is_touched" [] {
  (git status --porcelain) != ""
}

def "git untracked_count" [] {
  git status --porcelain
  | lines
  | where $it =~ '\?\? *'
  | length
}

def "git modified_count" [] {
  git status --porcelain
  | lines
  | where $it =~ 'M *' or $it =~ 'A *' or $it =~ 'D *'
  | length
}

def "git ahead_count" [] {
  if (test {git log}) {
    git log
    | lines
    | where ($it | str starts-with "commit ")
    | length
  } else {
    0
  }
}

def "git branch_name" [] {
  git symbolic-ref --short HEAD
}
