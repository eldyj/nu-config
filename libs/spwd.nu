# short pwd
def spwd [
  --house(-h): bool   # replace tilda with house character
  --tiny(-t): bool    # don't add s2nd character to dotfiles
  --bold(-b): bool    # maked last segment bold
  --noreset(-r): bool # don't reset style after last segment (if --bold)
] {
  let home_char = (if $house {
    char nf_house1
  } else {
    "~"
  })

  let spwd_paths = (
    $"!($env.PWD)" |
      str replace $"!($cross_home)" $home_char -s |
      split row (char psep)
  )

  let spwd_len = (($spwd_paths | length) - 1)

  $spwd_paths
  | enumerate
  | each {|el|
    let spwd_src = ($el.item | split chars)
    if ($el.index == $spwd_len) {
      if $bold {
        $"(ansi attr_bold)($el.item)(if not $noreset {ansi reset})"
      } else {
        $el.item
      }
    } else if ($spwd_src.0 == "." and (not $tiny)) {
      $".($spwd_src.1)"
    } else {
      $"($spwd_src.0)"
    }
  }
  | str join (char psep)
}

