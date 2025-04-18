return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      vue = { "prettier" },
      json = { "prettier" },
      html = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
    },
    formatters = {
      prettier = {
        command = "prettier",
        args = {
          "--stdin-filepath",
          "$FILENAME",
        },
        -- prefer local prettier
        prepend_args = function(_, ctx)
          local local_prettier = vim.fn.findfile("node_modules/.bin/prettier", ctx.dirname)
          if local_prettier ~= "" then
            return { local_prettier }
          end
        end,
      },
    },
  },
}

