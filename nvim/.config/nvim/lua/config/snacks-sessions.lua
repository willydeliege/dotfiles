local function tmux_sessions()
  -- Fetch the list of tmux sessions
  local handle = io.popen("sesh list --hide-duplicates 2>/dev/null")
  if not handle then
    print("Failed to run tmux command")
    return
  end
  local result = handle:read("*a")
  handle:close()

  -- Clean and parse output into a table formatted for snacks.picker
  local items = {}
  for session in string.gmatch(result, "[^\r\n]+") do
    table.insert(items, { text = session, value = session })
  end

  if #items == 0 then
    print("No active tmux sessions found or not inside tmux")
    return
  end

  -- Feed the sessions into snacks.picker
  Snacks.picker.pick({
    source = "tmux_sessions",
    items = items,
    title = "Tmux Sessions",
    prompt = "Tmux Sessions> ",
    actions = {
      confirm = function(picker, item)
        picker:close()
        if item and item.value then
          -- Switch to the selected tmux session
          vim.fn.system(string.format("sesh connect '%s'", item.value))
        end
      end,
    },
  })
end

-- Map it to a key combination
vim.keymap.set("n", "<leader>fp", tmux_sessions, { desc = "Snacks Picker Tmux Sessions" })
