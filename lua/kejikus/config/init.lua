-- Set vim options
require 'kejikus.config.options'

-- Apply common (non-plugin) remaps
require('kejikus.config.remaps').set_common_keymaps()

-- Register autocommands
require('kejikus.config.autocommands').set_common_autocmd()

-- Load custom global tools
require 'kejikus.config.globals'
