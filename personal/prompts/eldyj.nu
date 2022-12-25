# left prompt
def "prompt left" [] {
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

    # git branch
    [
      "black3",
      "cyan1",
      (if test {git branch} {
        $"(char nf_branch) (git branch --show-current)"
      })
    ],

    # current directory (shorted)
    [
      "black2",
      "blue2",
      $"(char nf_folder1) (spwd)"
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
        $"\(($env.LAST_EXIT_CODE)\) (char failed)"
      })
    ]
  ]
}
