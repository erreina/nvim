-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

local function close_other_windows()
  local current_win = vim.api.nvim_get_current_win()
  local wins = vim.api.nvim_list_wins()

  for _, win in ipairs(wins) do
    if win ~= current_win then
      vim.api.nvim_win_close(win, false)
    end
  end
end
vim.api.nvim_create_user_command("CloseOtherWindows", close_other_windows, {})
keymap.set("n", "<leader>wo", "<cmd>CloseOtherWindows<CR>", { desc = "Close other windows" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "h", "hpp" },
  callback = function()
    vim.keymap.set("n", "<leader>ct", function()
      local file = vim.fn.expand("%:p") -- Get full file path
      local base_name = file:gsub("%.hpp$", ""):gsub("%.h$", ""):gsub("%.cpp$", "")
      local test_file = base_name .. "_test.cpp"

      if vim.fn.filereadable(test_file) == 1 then
        vim.cmd("edit " .. test_file)
      else
        local choice = vim.fn.input("Test file not found. Create it? (y/n) ")
        if choice:lower() == "y" then
          vim.fn.writefile({}, test_file) -- Create an empty file
          vim.cmd("edit " .. test_file)   -- Open the file
          print("Created test file: " .. test_file)
        else
          print("Cancelled: Test file not created.")
        end
      end
    end, { buffer = true, desc = "Jump to test file (or create it)" })
  end,
})

