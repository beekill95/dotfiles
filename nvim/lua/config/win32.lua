-- Windows' specific configuration.

-- FIXME: right now doesn't work with lazygit!
-- Set the default shell.
-- vim.cmd [[let &shell = 'powershell.exe']]
-- This is to start the developer powershell for VS 2022
-- It is copied from Windows' Terminal setting.
-- Note that: replace the triple double-quotes (""") with \"
-- vim.cmd [[let &shellcmdflag = '-NoExit -Command "&{Import-Module \"C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll\"; Enter-VsDevShell 6a27c4d6 -SkipAutomaticLocation -DevCmdArguments \"-arch=x64 -host_arch=x64\"}"']]
