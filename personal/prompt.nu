# left prompt
def "prompt left" [] {
  eprompt theme powerline -c nord [
    [bg,fg,text];
    
    # os icon
    [
      "black2",
      "cyan2",
      (os_icon)
    ]
  
    # username
    [
      "black1",
      "white2",
      (cross username)
    ],

    # git branch
    [
      "black3",
      "cyan1",
      (if (do -i {git branch} | complete).stderr == "" {
        git branch --show-current
        | str replace -a "\n" ""
      })
    ],

    # current directory (shorted)
    [
      "black2",
      "blue2",
      (spwd)
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
      (date now | date format "%H:%M:%S")
    ],

    # last command execution time
    [
      "black3",
      "cyan1",
      (if (cmd_duration | $in >= 1) {
        $"(cmd_duration | math round) s"
      })
    ],

    # last exit code (if error)
    [
      "red1",
      "white3",
      (if $env.LAST_EXIT_CODE != 0 {
        $"(char failed) \(($env.LAST_EXIT_CODE)\)"
      })
    ]
  ]
}

let-env PROMPT_INDICATOR = {""}
let-env PROMPT_COMMAND = {prompt left}
let-env PROMPT_COMMAND_RIGHT = {prompt right}
