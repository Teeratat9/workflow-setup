return {
  -- Full-screen diff review: side-by-side diffs, file panel, branch/PR history.
  -- Complements gitsigns (inline hunks) and lazygit (staging/committing).
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        merge_tool = { layout = "diff3_mixed" },
      },
    },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview (working tree)" },
      { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview Branch History" },
      { "<leader>gm", "<cmd>DiffviewOpen origin/HEAD...HEAD<cr>", desc = "Diffview vs origin/HEAD" },
    },
  },

  -- Interactive commit graph. Enter on a commit opens it in Diffview;
  -- marking two commits diffs the range.
  {
    "isakbm/gitgraph.nvim",
    dependencies = { "sindrets/diffview.nvim" },
    cmd = "GitGraph",
    opts = {
      format = {
        timestamp = "%Y-%m-%d",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      },
      hooks = {
        on_select_commit = function(commit)
          vim.cmd(("DiffviewOpen %s^!"):format(commit.hash))
        end,
        on_select_range_commit = function(from, to)
          vim.cmd(("DiffviewOpen %s~1..%s"):format(from.hash, to.hash))
        end,
      },
    },
    config = function(_, opts)
      require("gitgraph").setup(opts)
      vim.api.nvim_create_user_command("GitGraph", function()
        require("gitgraph").draw({}, { all = true, max_count = 512 })
      end, { desc = "Git commit graph" })
    end,
    keys = {
      { "<leader>gt", "<cmd>GitGraph<cr>", desc = "Git Graph (interactive)" },
    },
  },

  -- Plain `git log --graph --oneline` in a terminal split — nothing to learn,
  -- same output as the shell, scrollable and searchable with / like any buffer.
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gA",
        function()
          Snacks.terminal(
            { "git", "log", "--graph", "--oneline", "--all", "--decorate", "--color=always" },
            { win = { position = "float", width = 0.9, height = 0.9 }, interactive = true }
          )
        end,
        desc = "Git Log Graph (all branches)",
      },
      {
        "<leader>ga",
        function()
          Snacks.terminal(
            { "git", "log", "--graph", "--oneline", "--decorate", "--color=always" },
            { win = { position = "float", width = 0.9, height = 0.9 }, interactive = true }
          )
        end,
        desc = "Git Log Graph (current branch)",
      },
    },
  },
}
