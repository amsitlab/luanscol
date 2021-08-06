easy way to use ansi color with lua

## Installation
* Using [LuaRocks](https://luarocks.org)
```sh
luarocks install luanscol
```
## Style
### Foreground
- `b` is bold
- `B` is blink (maybe not work on some device)
- `d` is dim
- `h` is hidden
- `H` is use light color
- `i` is inverse
- `n` is normal
- `u` is underline
- `s` is strikethrough

### Background
- `H` is use light color

### Pattern
Style use string with format `<fgstyle>:<bgstyle>` look like:

`bH` 
 * fg is _bold, light_
 * bg is no style

`buH`
 * fg is _bold, underline, light_
 * bg is no style

`buH:H`
 * fg is _bold,underline, light_
 * bg is _light_

etc...

## Object

### Params
Params is one of:
1. `black`
2. `red`
3. `yellow`
4. `green`
5. `blue`
6. `magenta`
7. `cyan`
8. `white`

### Create
```lua
local luanscol = require 'luanscol'
local cyan = luanscol.object 'cyan'
```

## Usage

### Easy way
```lua
local color = require 'luanscol'
local cyan = color.object 'cyan'

print(cyan:magenta 'Cyan on Magenta')


print(cyan:magenta 'Cyan on Magenta with bold' + 'b')


print(cyan:magenta 'CyanLight on Magenta with bold' + 'bH')


print(cyan:magenta 'CyanLight on MagentaLight with bold' + 'bH:H')



```
see [Style]	(##Style)


### Advance
```lua
local luanscol = require 'luanscol'

-- cyan with underline
local title = luanscol.Cyan 'u' 

-- print title with fg cyan bg white with underline style
print(cyan:white 'Cyan on white with underline')
```



## Test
### LuaRocks
```sh
luarocks test
```


### Manual
```sh
lua test.lua
```
