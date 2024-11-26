return {
  "L3MON4D3/LuaSnip",
  -- follow latest rel  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local sn = ls.snippet_node
    local isn = ls.indent_snippet_node
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local r = ls.restore_node
    local events = require("luasnip.util.events")
    local ai = require("luasnip.nodes.absolute_indexer")
    local extras = require("luasnip.extras")
    local l = extras.lambda
    local rep = extras.rep
    local p = extras.partial
    local m = extras.match
    local n = extras.nonempty
    local dl = extras.dynamic_lambda
    local fmt = require("luasnip.extras.fmt").fmt
    local fmta = require("luasnip.extras.fmt").fmta
    local conds = require("luasnip.extras.expand_conditions")
    local postfix = require("luasnip.extras.postfix").postfix
    local types = require("luasnip.util.types")
    local parse = require("luasnip.util.parser").parse_snippet
    local ms = ls.multi_snippet
    local k = require("luasnip.nodes.key_indexer").new_key

    ls.add_snippets('all', {
      ls.s('time', p(vim.fn.strftime, '%H:%M:%S')),
      ls.s('date', p(vim.fn.strftime, '%Y-%m-%d')),
    })

    ls.add_snippets('all', {
      s("jump", {
        i(1, "First jump"),
        t(" :: "),
        c(2, {
          t("Jump 2 choice 1"),
          t("Jump 2 choice 2")
        }),
        t(" : "),
        i(3, "Third jump")
      }),
      s("choi", c(1, {
        t("Ugh boring, a text node"),
        i(nil, "At least I can edit something now..."),
        f(function(args) return "Still only counts as text!!" end, {})
      }))
    })

    ls.add_snippets('go', {
      s("logi", {
        c(1, {
          sn(nil,{t("logrus.Info("),i(1),t(")")}),
          sn(nil,{t("logrus.Error("),i(1),t(")")}),
          sn(nil,{t("logrus.Debug("),i(1),t(")")}),
          sn(nil,{t("logrus.Warn("),i(1),t(")")})
        }),
      }),
      s("choi", c(1, {
        t("Ugh boring, a text node"),
        i(nil, "At least I can edit something now..."),
        f(function(args) return "Still only counts as text!!" end, {})
      }))
    })

    -- vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-H>", function() ls.jump(-1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-J>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, {silent = true})

  end,
}
