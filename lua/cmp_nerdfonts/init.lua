local source = {}

source.setup = function()
  local self = setmetatable({}, { __index = source })
  self.commit_items = nil
  self.insert_items = nil
  return self
end

function source.script_path()
  local str = debug.getinfo(2, 'S').source:sub(2)
  return str:match('(.*' .. '/' .. ')')
end

source.get_trigger_characters = function()
  return { 'nf-' }
end

source.complete = function(self, params, callback)
  callback(require('cmp_nerdfonts.glyphs'))
end

source.update = function()
  local handle = io.popen("curl -s https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/glyphnames.json")
  local result = handle:read("*a")
  handle:close()

  local json = vim.fn.json_decode(result)
  local items = ''

  for name, glyph in pairs(json) do
    if glyph.char ~= nil then
      name = 'nf-' .. name
      local line = ("{ word = '%s', label = '%s', insertText = '%s', filterText = '%s' },\n"):format(
        name,
        glyph.char .. ' ' .. name .. '  (' .. glyph.code .. ')',
        glyph.char,
        name
      )
      items = items .. line
    end
  end

  local path = debug.getinfo(1).source:sub(2):sub(1, -9) .. 'glyphs.lua'
  local target = io.open(path, 'w')
  target:write(('return {\n%s}'):format(items))
  io.close(target)
end

return source
