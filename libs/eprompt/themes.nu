def "eprompt themes" [] {
  {
    powerline: {
      normal: {
        sep: (char nf_segment),
        pre: null
      },

      reverse: {
        sep: (char nf_right_segment),
        pre: null
      }
    },

    rounded: {
      normal: {
        sep: (char -i 0xE0B4),
        pre: (char -i 0xE0B6)
      },

      reverse: {
        sep: (char -i 0xE0B6),
        pre: (char -i 0xE0B4)
      }
    },

    nacked: {
      normal: {
        sep: (char -i 0xE0B8),
        pre: (char -i 0xE0BE)
      },

      reverse: {
        sep: (char -i 0xE0BE),
        pre: (char -i 0xE0B8)
      }
    },

    nacked-upside: {
      normal: {
        sep: (char -i 0xE0BC),
        pre: (char -i 0xE0BA)
      },

      reverse: {
        sep: (char -i 0xE0BA),
        pre: (char -i 0xE0BC)
      }
    }

    flame: {
      normal: {
        sep: (char -i 0xE0C0),
        pre: (char -i 0xE0C2)
      },

      reverse: {
        sep: (char -i 0xE0C2),
        pre: (char -i 0xE0C0)
      }
    },

    ice: {
      normal: {
        sep: (char -i 0xE0C8),
        pre: (char -i 0xE0CA)
      },

      reverse: {
        sep: (char -i 0xE0CA),
        pre: (char -i 0xE0C8)
      }
    }

    pixel: {
      normal: {
        sep: (char -i 0xE0C4)
        pre: (char -i 0xE0C5)
      }

      reverse: {
        sep: (char -i 0xE0C5)
        pre: (char -i 0xE0C4)
      }
    }

    bigpixel: {
      normal: {
        sep: (char -i 0xE0C6)
        pre: (char -i 0xE0C7)
      }

      reverse: {
        sep: (char -i 0xE0C7)
        pre: (char -i 0xE0C6)
      }
    }
  }
}

let eprompt_themes = (eprompt themes)
