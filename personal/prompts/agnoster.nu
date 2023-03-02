# left prompt
def "prompt left" [] {
  let git_ok = {
    bg: "green",
    fg: "black"
  }

  let git_status = (eprompt git_segment -f [
    $"(char nf_branch) %branch%",
    $"(char -i 0x00b1)%modified%",
    $"(char branch_ahead)%ahead%",
    $"(char branch_behind)%behind%"
  ] {
    clean: $git_ok,
    ahead: $git_ok,
    behind: $git_ok,
    dirty: {
      bg: "yellow",
      fg: "black"
    }
  })

  eprompt theme powerline [
    [bg,fg,text];

    # status
    [
      "black",
      "white",
      ([
        (if $env.LAST_EXIT_CODE != 0 {
          $"(ansi red)(char -i 0x2718)"
        }),

        (if (cross username) == "root" {
          $"(ansi yellow)(char -i 0x26A1)"
        }),

        #(if (jobs -l | lines | length) > 0 {
        #  $"(ansi cyan)(char -i 0x2699)"
        #})
      ]
      | where $it != null
      | str join " "
      )
    ]

    # context
    [
      "black",
      "white",
      $"($cross_username)@((sys).host.hostname)"
    ],

    # current directory (shorted)
    [
      "blue",
      "black",
      $"(spwd)"
    ],
   
    # git status
    [
      $git_status.bg,
      $git_status.fg,
      $git_status.text
    ]
  ]
}

let-env PROMPT_COMMAND = {prompt left}
let-env PROMPT_COMMAND_RIGHT = {""}
