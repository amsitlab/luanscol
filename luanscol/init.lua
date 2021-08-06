local esc = string.char(27) .. '[%s'
local colnums = {
   black = 0, -- fgbase:30 bgbase: 40 fghibase
   red = 1,
   green = 2,
   yellow = 3,
   blue = 4,
   magenta = 5,
   cyan = 6,
   white = 7
}
local attrs = {
   n = 0, -- nornal
   b = 1, -- bold
   d = 2, -- dim
   u = 4, -- underline
   B = 5, -- blink
   i = 7, -- inverse
   h = 8, -- hidden
   s = 9, -- strikethrough
}

local function parse_attribute(self, attr)
   assert(type(attr) == 'string')
   local pattern = '([BbdhHinsu]*):?([H]*)'
   self.__attr = {}
   local c
   for fgattr, bgattr in attr:gmatch(pattern) do
      for i=1, #fgattr, 1 do
         c = fgattr:sub(i,i)
         if c == 'H' then
            self.__fgbase = 90
         end
         if attrs[c] then
            table.insert(self.__attr, attrs[c])
         end
      end
      if bgattr:find('H') then
         self.__bgbase = 100
      end
   end
end



-- bgcode is one of `colnums` value
-- see local table `colnums`
-- psoudocode like
--   Cyan.black = create_method(0)
--   text = Cyan 'u'
--   print(test:black 'Cyan on black with underline')
--
local function create_method(bgcode)
   -- self is fg object,
   -- str is string want to coloring
   --
   return function (self, str)
      self.__str = str ~= nil and str or self.__str
      self.__bgcode = bgcode
      return self
   end
end

local function create(fgkey)
   assert(type(fgkey) == 'string')
   local fgcode = colnums[fgkey]
   local fgmeta, bgmeta = {}, {}

   function bgmeta:__tostring()
      local fg, bg, attr
      fg = self.__fgcode + self.__fgbase
      bg = self.__bgcode + self.__bgbase
      attr = #self.__attr > 0 and ';' .. table.concat(self.__attr, ';') or ''

      return string.format('%sm%s%sm%s%sm',
         esc:format(bg),
         esc:format(fg),
         attr,
         self.__str,
         esc:format(0)
      )
   end

   function bgmeta:__call(s)
      self.__str = s
      return tostring(self)
   end


   function bgmeta:__add(attr)
      assert(type(attr) == 'string')
      parse_attribute(self, attr)
      return tostring(self)

   end

   function bgmeta:__concat(other)
      return tostring(self) .. tostring(other)
   end

   local o = {}
   function fgmeta:__call(attr)
      attr = attr or ''
      assert(type(attr) == 'string')
      local obj = {
         __fgbase = 30,
         __bgbase = 40,
         __fgcode = colnums[fgkey],
         __bgcode = 9,
      }

      parse_attribute(obj, attr)
      for name,code in pairs(colnums) do
         -- obj['black'] = create_method(0)
         -- obj['red'] = create_method(1)
         -- etc..
         -- see create_method and colnums
         obj[name] = create_method(code)
      end

      o = obj
      return setmetatable(obj, bgmeta)
   end
   return setmetatable({}, fgmeta)
end

local M = {
   New = create,
   Black = create('black'),
   Red = create('red'),
   Yellow = create('yellow'),
   Blue = create('blue'),
   Magenta = create('magenta'),
   Cyan = create('cyan'),
   White = create('white'),
}

function M.object(s)
   assert(type(s) == 'string')
   if not colnums[s] then
      local name = ''
      for k, v in pairs(colnums) do
         name = name .. ', ' .. k
      end
      -- remove ',' thats first on characters `name`
      name = name:sub(2)
      error('Invalid object "' .. s .. '", choose 1 of (' .. name .. ')')
   end
   -- upper case first char on `s`
   s = s:gsub('^%l', string.upper)

   return M[s]()
end

return M
