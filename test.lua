local luanscol = require 'luanscol'


local cyan = luanscol.object 'cyan'
local Cyan = luanscol.Cyan


local title = Cyan 'u'

-- text fg is cyan with underline
print(title:magenta 'Title' .. '<- title is cyan on magenta with underline') -- title with bg magenta
print(title:magenta 'Title' + 'b' .. '<- title is cyan on magenta with bold') -- title with bg magenta and bold



print('cyan:magenta "cyan on magenta" -> ' .. cyan:magenta 'cyan on magenta')
print('cyan:magenta "cyan on magenta with underline" + "u" -> ' .. cyan:magenta 'cyan on magenta with underline' + 'u')
print()
print(cyan:magenta 'cyan on magenta with bold' + 'b')
print(cyan:magenta 'cyan on magenta with dim' + 'd')
print(cyan:magenta 'cyan on magenta with inverse' + 'i')
print(cyan:magenta 'cyan on magenta with blink' + 'B')
print(cyan:magenta 'cyan on magenta with strikethrough' + 's')
print(cyan:magenta 'cyan on magenta with normal' + 'n')
print(cyan:magenta 'cyan on magenta with hidden' + 'h' .. '<- hidden')
print(cyan:magenta 'cyanlight on magentalight ' + 'H:H')
print(cyan:magenta 'cyanlight on magentalight with bold' + 'Hb:H')


