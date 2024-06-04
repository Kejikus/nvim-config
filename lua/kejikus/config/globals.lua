-- Global function library
kejikus = {}

function kejikus.reload_module(module_name)
  package.loaded[module_name] = nil
  return require(module_name)
end
