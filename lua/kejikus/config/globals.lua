-- Global function library
Me = {}

function Me.reload_module(module_name)
  package.loaded[module_name] = nil
  return require(module_name)
end
