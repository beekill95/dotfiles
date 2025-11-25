require('config.autoread')
require('config.persistent-undo')
require('config.providers')
require('config.remap')
require('config.set')

if jit.os == 'Windows' then
    require('config.win32')
end

require('config.lazy')
require('config.lsp')
-- require('config.packer')
