{...}: {
  config = {
    plugins.comment-nvim = {
      enable = true;
      mappings = {
        basic = false;
        extra = false;
      };
    };
    maps = {
      normal = {
        "<leader>/" = {
          action = ''function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end'';
          silent = true;
          lua = true;
          desc = "Comment line";
        };
      };
      visual = {
        "<leader>/" = {
          action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>";
          silent = true;
          desc = "Comment line";
        };
      };
    };
  };
}
