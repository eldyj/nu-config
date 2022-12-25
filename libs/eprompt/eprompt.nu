# prompt function
def eprompt [
  --sep(-s): string,  # separator
  segments: any,      # list of segments
  --pre(-p): string,  # displayed before first segment
  --mode(-m): string  # mode: normal || left, reversed || right
] {
  let reverse = ($mode in [reversed, right])
  let segments = (clean_list $segments -k text)
  let segments = (if $reverse {$segments | reverse} else {$segments})

  $segments
  | each {|segment,index|
      let pre = (if ($index != 0 and (not $reverse)) or ($index < ($segments | length | $in - 1) and $reverse) {
      let prev = (
        $segments
        | get ($index - (if $reverse {-1} else {1}))
      )
      $"(ansix -f $prev.bg -b $segment.bg)($sep)"
    } else if $pre != null {$"(ansi reset)(ansix -f ($segments | get $index).bg)($pre)"})
    if $reverse {
      $"(ansi reset)(ansix -f $segment.fg -b $segment.bg) ($segment.text) ($pre)"
    } else {
      $"(ansi reset)($pre)(ansix -f $segment.fg -b $segment.bg) ($segment.text) "
    }
  }
  | append (ansi reset)
  | prepend (if $reverse {$"(ansi reset)(ansix -f $segments.0.bg)($sep)(ansi reset)"})
  | append (if (not $reverse) {$"(ansi reset)(ansix -f ($segments | last).bg)($sep)(ansi reset) "})
  | str collect ""
}

# eprompt themes
def "eprompt theme" [
  theme: string,                  # powerline, rounded, nacked, nacked-upside
  segments: any,                  # list of segments
  --colorscheme(-c): string,      # colorscheme
  --nopre(-p): bool,              # ignore theme "pre"
  --reverse(-r): bool             # for right prompt
] {
  let mode = (if $reverse {"right"} else {"left"})
  let current_theme = (if $theme in $eprompt_themes {
    $eprompt_themes
    | get $theme
  } else {
    $eprompt_themes.powerline
  })

  let current_theme = (if $reverse {$current_theme.reverse} else {$current_theme.normal})
  let segments = (clean_list (clean_list $segments -k bg) -k fg)
  let segments = (if $colorscheme != null {
    $segments
    | each {|el|
      {
        bg: (ansix theme $colorscheme -f $el.bg -c),
        fg: (ansix theme $colorscheme -f $el.fg -c),
        text: $el.text
      }
    }
  } else {
    $segments
  })
  eprompt -s $current_theme.sep -p (if not $nopre {$current_theme.pre}) -m $mode $segments
}

def "eprompt test" [--all(-a):bool] {
  let test = [
    [bg,fg,text];

    [
      "black1",
      "white3",
      "just"
    ],

    [
      "red1",
      "black1",
      "a"
    ],

    [
      "black2",
      "yellow1",
      "test"
    ]
  ]

  [
    "ayu",
    "catpuccin",
    "dracula",
    "nord",
    "tokyo night",
    "tommorow night",
    "gruvbox",
    "ohmynu"
  ]
  | each {|colorscheme|
    let test = (
      $test
      | append {
        bg:"black3",
        fg:"red1",
        text:$colorscheme
      }
    )

    for theme in [
        "powerline",
        "rounded",
        "nacked",
        "nacked-upside",
        "flame",
        "ice",
        "pixel",
        "bigpixel"
    ] {
      let test = (
        $test
        | append {
          bg:"black4",
          fg:"orange1",
          text:$theme
        }
      )

      [
        (if $all {
          eprompt theme $theme -c $colorscheme $test -p -r
        }),
        (eprompt theme $theme -c $colorscheme $test -p)
      ]
      | str collect ""
    }
  }
}
