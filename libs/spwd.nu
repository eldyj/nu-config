# short pwd
def spwd [] {
  let spwd_paths = (
    $"!($env.PWD)" |
      str replace $"!($cross_home)" (char nf_house1) -s |
      split row (char psep)
  )

  let spwd_len = (($spwd_paths | length) - 1)

  $spwd_paths
  | each {|el, id|
    let spwd_src = ($el | split chars)
    if ($id == $spwd_len) {
      $el
    } else if ($spwd_src.0 == ".") {
      $".($spwd_src.1)"
    } else {
      $"($spwd_src.0)"
    }
  }
  | str join (char psep)
}

