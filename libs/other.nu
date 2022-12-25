# last command duration in seconds
def cmd_duration [] {
  $env.CMD_DURATION_MS
  | into int
  | $in * 1ms / 1sec
}

# array without nulls and empty strings
def clean_list [l ,--key(-k): string] {
  $l
  | each {|el|
    let val = (
      if not ($key in [null,""]) {
        $el
        | get $key
      } else {
        $el
      }
    )
    if not ($val in [null,""]) {
      $el
    }
  }
}

def test [
  target: block
] {
  do -i $target
  | complete
  | get stderr
  | $in == ""
}

def os_icon [] {
  let os = ((sys).host.long_os_version | str downcase)
  if $os =~ windows {
    char -i 0xf17a
  } else if $os =~ bsd {
    char -i 0xf30c
  } else if $os =~ linux {
    if $os =~ zorin {
      char -i 0xf32f
    } else if $os =~ void {
      char -i 0xf32e
    } else if $os =~ solus {
      char -i 0xf32d
    } else if $os =~ slackware {
      char -i 0xf318
    } else if $os =~ sabayon {
      char -i 0xf317
    } else if $os =~ rocky {
      char -i 0xf32b
    } else if $os =~ redhat {
      char -i 0xf316
    } else if $os =~ pop {
      char -i 0xf32a
    } else if $os =~ suse {
      char -i 0xf314
    } else if $os =~ nix {
      char -i 0xf313
    } else if $os =~ mandriva {
      char -i 0xf311
    } else if $os =~ mageia {
      char -i 0xf310
    } else if $os =~ mint {
      char -i 0xf30f
    } else if $os =~ kali {
      char -i 0xf327
    } else if $os =~ endeavour {
      char -i 0xf322
    } else if $os =~ deepin {
      char -i 0xf321
    } else if $os =~ element {
      char -i 0xf309
    } else if $os =~ devuan {
      char -i 0xf307
    } else if $os =~ core {
      char -i 0xf305
    } else if $os =~ artix {
      char -i 0xf31f
    } else if $os =~ archlabs {
      char -i 0xf31e
    } else if $os =~ arch {
      char -i 0xf303
    } else if $os =~ alma {
      char -i 0xf31d
    } else if $os =~ alpine {
      char -i 0xf300
    } else if $os =~ fedora {
      char -i 0xf30a
    } else if $os =~ cent {
      char -i 0xf304
    } else if $os =~ ubuntu {
      char -i 0xf31b
    } else if $os =~ manjaro {
      char -i 0xf312
    } else if $os =~ debian {
      char -i 0xf306
    } else if $os =~ gentoo {
      char -i 0xf30d
    } else if $os =~ guix {
      char -i 0xf325
    } else if $os =~ illum {
      char -i 0xf326
    } else {
      char -i 0xf17c
    }
  } else if $os =~ osx or $os =~ mac or $os =~ ios {
    char -i 0xf302
  } else if $os =~ gnu {
    char -i 0xe779
  }
}

let os_icon = (os_icon)
