# get username for unix and windows
def "cross username" [] {
  if ($nu.os-info.name =~ windows) {
    $env.USERNAME
  } else {
    $env.USER
  }
}

# get homedir for unix and windows
def "cross home" [] {
  if ($nu.os-info.name =~ windows) {
    $env.USERPROFILE
  } else {
    $env.HOME
  }
}

let cross_username = (cross username)
let cross_home = (cross home)
