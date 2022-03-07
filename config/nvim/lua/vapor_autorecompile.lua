M = {}
M.autocompile_progress=""
M.autocompile_error=""
M.get_autocompile_status = function()
    return 'status: '..M.autocompile_progress..' error: '..M.autocompile_error
end

vim.o.statusline = "%!v:lua.M.get_autocompile_status()"

local Job = require'plenary.job'

local swift_autorecompile_job = Job:new({
  command = '/Users/petrpalata/code/swift-autorecompile/swift-autorecompile.sh',
  args = { '.' },
  cwd = '/Users/petrpalata/code/twitch-schedule-helper',
  on_stdout = function(out, data)
      M.autocompile_progress=data
      print(data)
  end,
  on_stderr = function(out, stderroutput)
      print(stderroutput)
      M.autocompile_error=stderroutput
  end
})

swift_autorecompile_job:start() -- or start()

return M
