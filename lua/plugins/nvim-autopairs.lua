require('nvim-autopairs').setup({
    disable_filetype = vim.g.quboid_disable_ft,
    enable_check_bracket_line = true,
    check_ts = true,
})

-- TODO: Add autopair to CMP
---- If you want insert `(` after select function or method item
--local cmp_autopairs = require('nvim-autopairs.completion.cmp')
--local cmp = require('cmp')
--cmp.event:on(
--  'confirm_done',
--  cmp_autopairs.on_confirm_done()
--)

local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

local cond = require('nvim-autopairs.conds')
print(vim.inspect(cond))

-- marktex mathblock completion
npairs.add_rules({
    Rule("$", "$", vim.g.quboid_ft_marktex)
        -- don't add a pair if the next character is %
        :with_pair(cond.not_after_regex("%%"))
        -- don't add a pair if  the previous character is xxx
        :with_pair(cond.not_before_regex("xxx", 3))
        -- don't move right when repeat character
        :with_move(cond.none())
        -- don't delete if the next character is xx
        :with_del(cond.not_after_regex("xx"))
        -- disable adding a newline when you press <cr>
        :with_cr(cond.none())
})

npairs.add_rules({
    Rule("$$","$$",vim.g.quboid_ft_marktex)
        :with_pair(function(opts)
            print(vim.inspect(opts))
            if opts.line=="aa $$" then
            -- don't add pair on that line
                return false
            end
        end)
   }
)

-- Add spaces between brackets
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1]..brackets[1][2],
        brackets[2][1]..brackets[2][2],
        brackets[3][1]..brackets[3][2],
      }, pair)
    end)
}
for _,bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(bracket[1]..' ', ' '..bracket[2])
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%'..bracket[2]) ~= nil
      end)
      :use_key(bracket[2])
  }
end

-- js function completion
npairs.add_rules {
 Rule('%(.*%)%s*%=>$', ' {  }', vim.g.quboid_ft_js)
        :use_regex(true)
        :set_end_pair_length(2),
}

-- Close braces
local get_closing_for_line = function (line)
  local i = -1
  local clo = ''

  while true do
    i, _= string.find(line, "[%(%)%{%}%[%]]", i + 1)
    if i == nil then break end
    local ch = string.sub(line, i, i)
    local st = string.sub(clo, 1, 1)

    if ch == '{' then
      clo = '}' .. clo
    elseif ch == '}' then
      if st ~= '}' then return '' end
      clo = string.sub(clo, 2)
    elseif ch == '(' then
      clo = ')' .. clo
    elseif ch == ')' then
      if st ~= ')' then return '' end
      clo = string.sub(clo, 2)
    elseif ch == '[' then
      clo = ']' .. clo
    elseif ch == ']' then
      if st ~= ']' then return '' end
      clo = string.sub(clo, 2)
    end
  end

  return clo
end

npairs.remove_rule('(')
npairs.remove_rule('{')
npairs.remove_rule('[')

npairs.add_rule(
  Rule("[%(%{%[]", "")
  :use_regex(true)
  :replace_endpair(function(opts)
    return get_closing_for_line(opts.line)
  end)
  :end_wise()
)
