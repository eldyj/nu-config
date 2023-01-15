def "nusm asm" [] {
  if (which nasm) != null {
    "nasm"
  } else if (which yasm) != null {
    "yasm"
  } else if (which fasm) != null {
    "fasm"
  } else {
    error make {
      label:{
        text:"you haven't any of supported assembly compillers\nsupported compillers: nasm, yasm and fasm"
      },
      msg:"you haven't compiller!"}
  }
}

def-env "nusm new" [projectname:string] {
  mkdir $projectname
  echo '%include "macro.asm"'
  | save $"($projectname)/($projectname).asm"
  echo $"entry: ($projectname)\nformat: (nusm asm)\nbits: 64\nno_log: false"
  | save $"($projectname)/config.yaml"
  cd $projectname
  cp -r ~/.config/nushell/scripts/nusm/assets/ ./assets
}

def "nusm compile" [filename?:string, bits?:int, --format(-f):string] {
  let config = (if ($filename == null) and ($format == null) {
    #echo "[INFO] using config"
    open config.yaml
  } else {
    {
      entry: (if $filename != null {$filename} else {
        error make {
          label:{
            text:"you can create file with config or just pass filename as first argument"
          }
          msg:"no file provided"
        }
      })
      bites: (if $bits != null {$bits} else {0})
      format: (if $format != null {$format} else {nusm asm})
      no_log: false
    }
  })
  let bits = $config.bits
  let filename = $config.entry
  let format = $config.format
  let no_log = $config.no_log
  if $bits == 0 {
    nusm compile $filename 32 -f $format
    0..60
    | each {"="}
    | str join ""
    | echo $in
    nusm compile $filename 64 -f $format
    return
  }
  let start_time = (date now)
  let assets_format = (if $format in ["nasm", "yasm"] {
   "nasm" 
  } else {
    $format
  })

  echo $"[INFO] starting compilation of ($format)@($bits)"
  #echo $"[CMD] mkdir target/($format)/($bites)"
  mkdir $"target/($format)/($bits)"

  let ls_elf = (if $bits == 32 {"i386"} else if $bits == 64 {"x86_64"} else {"none"})
  let nasm_f = (if $bits == 32 or $bits == 64 {$"elf($bits)"} else {"bin"})
 
  echo "[INFO] copying compilation-time stuff from assets"
  cp $"assets/($assets_format)/($bits)bit.asm" "currentbit.asm"
  cp $"assets/($assets_format)/macro.asm" "macro.asm"
  if $format == fasm {
    echo $"[INFO] replacing %include to include in ($filename).fasm"
    open $"($filename).asm"
    | str replace -s -a "%include" "include"
    | save $"($filename).fasm"
    echo $"[CMD ] fasm ($filename).fasm(if not $no_log {' > fasm.log'})"
    fasm $"($filename).fasm" | save -f fasm.log
    if $no_log {
      rm fasm.log
    }
    rm $"($filename).fasm"
    mv -f $filename $"target/($format)/($bits)/($filename)"
  } else {
    echo $"[CMD ] ($format) -f ($nasm_f) ($filename).asm -o target/($format)/($bits)/($filename).o"
    sh -c $"($format) -f ($nasm_f) ($filename).asm -o target/($format)/($bits)/($filename).o"
  }

  if $ls_elf != "none" and $format != fasm {
    echo "[INFO] linking flat binary to executable"
    ld -m $"elf_($ls_elf)" -o $"target/($format)/($bits)/($filename)" $"target/($format)/($bits)/($filename).o"
    echo "[INFO] removing flat binary file"
    rm $"target/($format)/($bits)/($filename).o"
  }

  echo "[INFO] removing compilation-time stuff"
  rm "macro.asm"
  rm "currentbit.asm"
  echo $"[INFO] target ($format)@($bits) compilled in ((date now) - $start_time)"
  return
}
