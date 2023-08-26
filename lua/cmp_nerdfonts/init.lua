local source = {}

source.setup = function()
  local self = setmetatable({}, { __index = source })
  self.commit_items = nil
  self.insert_items = nil
  return self
end

source.get_trigger_characters = function()
  return { 'nf-' }
end

source.complete = function(self, params, callback)
  callback(require('cmp_nerdfonts.glyphs'))
end

source.update = function()
  local json = vim.fn.json_decode(
    vim.fn.readfile('./glyphnames.json')
  )

  local items = ''

  for name, glyph in pairs(json) do
    if glyph.char ~= nil then
      local line = ("{ word = '%s'; label = '%s'; insertText = '%s'; filterText = '%s' };\n"):format(
        name,
        glyph.char .. ' ' .. name .. '  (' .. glyph.code .. ')',
        glyph.char,
        name
      )
      items = items .. line
    end
  end

  local target = io.open('./glyphs.lua', 'w')
  target:write(('return {\n%s}'):format(items))
  io.close(target)
end

return source
