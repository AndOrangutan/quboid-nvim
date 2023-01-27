require("barbecue").setup({
    attach_navic = false,
    symbols = {
    ---modification indicator
    ---@type string
    modified = "●",

    ---truncation indicator
    ---@type string
    ellipsis = "…",

    ---entry separator
    ---@type string
    separator = "",
  },

  ---icons for different context entry kinds
  ---`false` to disable kind icons
  ---@type table<string, string>|false
  kinds = {
    Array           = " ",
    Boolean         = " ",
    Class           = " ",
    Constant        = " ",
    Constructor     = " ",
    Enum            = " ",
    EnumMember      = " ",
    Event           = " ",
    Field           = " ",
    File            = " ",
    Function        = " ",
    Interface       = " ",
    Key             = " ",
    Method          = " ",
    Module          = " ",
    Namespace       = " ",
    Null            = " ",
    Number          = " ",
    Object          = " ",
    Operator        = " ",
    Package         = " ",
    Property        = " ",
    String          = " ",
    Struct          = " ",
    TypeParameter   = " ",
    Variable        = " ",
  },
})
