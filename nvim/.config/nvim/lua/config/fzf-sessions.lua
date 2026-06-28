local fzf = require("fzf-lua")

local function tmux_sessions()
  -- Fetch the list of tmux sessions
  local handle = io.popen("tmux list-sessions -F '#{session_name}' 2>/dev/null")
  if not handle then
    print("Failed to run tmux command")
    return
  end

  local result = handle:read("*a")
  handle:close()

  -- Clean and parse output into a table
  local sessions = {}
  for session in string.gmatch(result, "[^\r\n]+") do
    table.insert(sessions, session)
  end

  if #sessions == 0 then
    print("No active tmux sessions found or not inside tmux")
    return
  end

  -- Feed the sessions into fzf-lua
  fzf.fzf_exec(sessions, {
    prompt = "Tmux Sessions> ",
    actions = {
      ["default"] = function(selected)
        if selected and selected[1] then
          local target_session = selected[1]
          -- Switch to the selected tmux session
          vim.fn.system(string.format("tmux switch-client -t '%s'", target_session))
        end
      end,
    },
  })
end

-- Map it to a key combination (e.g., <leader>ts)
vim.keymap.set("n", "<leader>ts", tmux_sessions, { desc = "Fzf-lua Tmux Sessions" })
