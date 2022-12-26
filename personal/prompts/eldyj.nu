# left prompt
def "prompt left" [] {
  let git_status = (eprompt git_segment {
    clean: {
      bg: "blue1",
      fg: "white4"
    },

    ahead: {
      bg: "cyan2",
      fg: "white4",
    },

    dirty: {
      bg: "yellow1",
      fg: "black1"
    }
  })

  eprompt theme powerline -c nord [
    [bg,fg,text];
    
    # os icon
    [
      "black2",
      "cyan2",
      $os_icon
    ]
  
    # username
    [
      "black1",
      "white2",
      $"(char -i 0xF2BE) ($cross_username)"
    ],

    # current directory (shorted)
    [
      "black2",
      "blue2",
      $"(char nf_folder1) (spwd)"
    ],

    # git branch
    [
      "black3",
      "cyan1",
      (if (git is_git_folder) {
        $"(char nf_branch) (git branch --show-current)"
      })
    ],
   
    # git status
    [
      $git_status.bg,
      $git_status.fg,
      $"(char nf_git) ($git_status.text)"
    ]
  ]
}

# right prompt
def "prompt right" [] {
  eprompt theme powerline -r -c nord [
    [bg,fg,text];

    # current time
    [
      "black2",
      "blue2",
      $"(date now | date format '%H:%M:%S') (char -i 0xf64f)"
    ],

    # crystal version
    [
      "black4",
      "white4",
      (if (ls) != null {
        if (
          ls
          | get name
          | where $it =~ '\.cr' or $it in [
            '.shards.yml'
          ]
          | length
        ) > 0 {
        if (test {crystal -v}) {
          crystal -v 
          | split row " "
          | get 1
          | str replace -a -s "-dev" ""
          | $"($in) (char -i 0xE62F)"
          | str replace -a -s "\n" ""
        }
      }})
    ]

    # rust version
    [
      "orange1",
      "white4",
      (if (ls) != null {
        if (
          ls
          | get name
          | where $it =~ '\.rs' or $it in [
            'Cargo.toml'
          ]
          | length
        ) > 0 {
        if (test {cargo --version}) {
          cargo --version 
          | split row " "
          | get 1
          | str replace -a -s "-stable" ""
          | str replace -a -s "-nightly" ""
          | str replace -a -s "-beta" ""
          | $"($in) (char -i 0xE7A8)"
          | str replace -a -s "\n" ""
        }
      }})
    ]

    # haskell version
    #[
    #  "pink1",
    #  "white4",
    #  (if (ls) != null {
    #    if (
    #      ls
    #      | get name
    #      | where $it =~ '\.hs' or $it =~ '\.cabal' or $it =~ '\.hs_boot' or $it in [
    #        '.stack.yml'
    #      ]
    #      | length
    #    ) > 0 {
    #    if (test {ghc --version}) {
    #      ghc --version 
    #      | split row " "
    #      | last
    #      | str replace -a -s "-dev" ""
    #      | $"($in) (char -i 0xE777)"
    #      | str replace -a -s "\n" ""
    #    }
    #  }})
    #]

    # python version
    #[
    #  "green1",
    #  "black3",
    #  (if (ls) != null {
    #  if (
    #      ls
    #      | get name
    #      | where $it =~ '\.py' or $it in [
    #        '.python-version',
    #        'Pipfile',
    #        'pyproject.toml'
    #      ]
    #      | length
    #    ) > 0 {
    #    if (test {python --version}) {
    #      python --version 
    #      | split row " "
    #      | get 1
    #      | str replace -a -s "-dev" ""
    #      | $"($in) (char -i 0xE73C)"
    #      | str replace -a -s "\n" ""
    #    }
    #  }})
    #]

    # lua version
    #[
    #  "cyan1",
    #  "white4",
    #  (if (ls) != null {
    #    if (
    #      ls
    #      | get name
    #      | where $it =~ '\.lua' or $it in [
    #        '.lua-version',
    #        'lua'
    #      ]
    #      | length
    #    ) > 0 {
    #    if (test {lua -v}) {
    #      lua -v 
    #      | split row " "
    #      | get 1
    #      | str replace -a -s "-dev" ""
    #      | $"($in) (char -i 0xE620)"
    #      | str replace -a -s "\n" ""
    #    }
    #  }})
    #]

    # js version
    #[
    #  "yellow1",
    #  "black2",
    #  (if (ls) != null {
    #    if (
    #      ls
    #      | get name
    #      | where $it !~ '\.json' and ($it =~ '\.js' or $it =~ '\.cjs' or $it =~ '\.mjs' or $it =~ '\.ts' or $it =~ '\.cts' or $it =~ '\.mts') or $it in [
    #        '.node-version',
    #        '.nvmrc',
    #        'node-modules'
    #      ]
    #      | length
    #    ) > 0 {
    #    if (test {node --version}) {
    #      node --version 
    #      | split row " "
    #      | get 0
    #      | str replace -a -s "v" ""
    #      | $"($in) (char -i 0xE718)"
    #      | str replace -a -s "\n" ""
    #    }
    #  }})
    #]

    # php version
    #[
    #  "blue1",
    #  "white4",
    #  (if (ls) != null {
    #    if (
    #      ls
    #      | get name
    #      | where $it =~ '\.php' or $it in [
    #        'composer.json',
    #        '.php-version'
    #      ]
    #      | length
    #    ) > 0 {
    #    if (test {php --version}) {
    #      php --version 
    #      | split row " "
    #      | get 1
    #      | str replace -a -s "-dev" ""
    #      | $"($in) (char -i 0xE608)"
    #      | str replace -a -s "\n" ""
    #    }
    #  }})
    #]

    # last command execution time
    [
      "black3",
      "cyan1",
      (if (cmd_duration) >= 1 {
        $"(cmd_duration | math round)s (char -i 0xf608)"
      })
    ],

    # last exit code (if error)
    [
      "red1",
      "white3",
      (if $env.LAST_EXIT_CODE != 0 {
        $"($env.LAST_EXIT_CODE) (char failed)"
      })
    ]
  ]
}

let-env PROMPT_COMMAND = {prompt left}
let-env PROMPT_COMMAND_RIGHT = {prompt right}
