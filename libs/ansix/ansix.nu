# ansi wrapper
def ansix [
  --bg(-b): any, # background color
  --fg(-f): any  # font color
] {
  [
    (if $fg != null {
      ansi $fg
    }),

    (if $bg != null {
      if $bg =~ "#" {
        ansi -e {bg:$bg}
      } else {
        ansi $"bg_($bg)"
      }
    })
  ]
  | str collect ""
}

# ansi wrapper with custom themes
def "ansix theme" [
  theme: string          # colorscheme
  --bg(-b): string,      # background color
  --fg(-f): string       # font color
  --justcolor(-c): bool  # return only color
] {
  let current_theme = ($ansix_colorschemes | get $theme)
  if $justcolor {
    if $fg in $current_theme {
      $current_theme | get $fg
    } else {
      $fg
    }
  } else {
    ansix -f (ansix theme $theme -c -f $fg) -b (ansix theme $theme -c -f $bg)
  }
}
