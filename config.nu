source ~/.config/nushell/personal/completions.nu
source ~/.config/nushell/personal/themes.nu

let-env config = {
  ls: {
    use_ls_colors: true
    clickable_links: false
  }

  rm: {
    always_trash: false
  }

  cd: {
    abbreviations: true
  }

  table: {
    mode: rounded
    index_mode: never
    trim: {
      methodology: wrapping
      wrapping_try_keep_words: true
      truncating_suffix: "~"
    }
  }

  explore: {
    highlight: { bg: 'green', fg: 'black' }
    status_bar: { bg: 'white', fg: 'black' }
    command_bar: { fg: 'white' }
    split_line: 'black'
    cursor: true
  }

  history: {
    max_size: 10000
    sync_on_enter: true
    file_format: "plaintext"
  }

  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "prefix"
    external: {
      enable: true
      max_results: 100
      completer: null
    }
  }

  filesize: {
    metric: true
    format: "auto"
  }

  color_config: $dark_theme
  use_grid_icons: true
  footer_mode: "25"
  float_precision: 2
  use_ansi_coloring: true
  edit_mode: emacs
  shell_integration: true
  show_banner: false
  render_right_prompt_on_last_line: false

  hooks: {
    display_output: {
      if (term size).columns >= 100 { table -e } else { table }
    }
  }

  menus: [
      {
        name: completion_menu
        only_buffer_difference: false
        marker: ""
        type: {
            layout: columnar
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
        }
        style: {
            text: cyan
            selected_text: cyan_reverse
            description_text: green
        }
      }
  ]

  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: emacs # Options: emacs vi_normal vi_insert
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
      event: { send: menuprevious }
    }
    {
      name: next_page
      modifier: control
      keycode: char_x
      mode: emacs
      event: { send: menupagenext }
    }
    {
      name: undo_or_previous_page
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
       }
    }
    {
      name: yank
      modifier: control
      keycode: char_y
      mode: emacs
      event: {
        until: [
          {edit: pastecutbufferafter}
        ]
      }
    }
    {
      name: unix-line-discard
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cutfromlinestart}
        ]
      }
    }
    {
      name: kill-line
      modifier: control
      keycode: char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cuttolineend}
        ]
      }
    }
  ]
}
