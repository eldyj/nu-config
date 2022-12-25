# left prompt
def "prompt left" [] {
  eprompt theme powerline -c ohmynu [
    [bg,fg,text];
    
    # os icon
    [
      "white3",
      "black1",
      $os_icon
    ]
  
    # current directory (shorted)
    [
      "blue2",
      "white4",
      $"(char nf_folder1) (spwd -t -b -r)"
    ],

    # git branch
    [
      "green1",
      "black1",
      (if test {git branch} {
        $"(char nf_branch) (git branch --show-current)"
      })
    ]
  ]
}

# right prompt
def "prompt right" [] {
  eprompt theme powerline -r -c ohmynu [
    [bg,fg,text];

    # current time
    [
      "white4",
      "black1",
      $"(date now | date format '%H:%M:%S') (char -i 0xf64f)"
    ],

    # last command execution time
    [
      "black1",
      "white4",
      (if (cmd_duration) >= 0.003 {
        $"(cmd_duration | $in * 1000 | math round) (char -i 0xf608)"
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

let-env PROMPT_COMMAND = {prompt left}
let-env PROMPT_COMMAND_RIGHT = {prompt right}
