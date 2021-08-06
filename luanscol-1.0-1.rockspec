package = "luanscol"
version = "1.0-1"
source = {
   url = "git://github.com/amsitlab/luanscol.git"
}
description = {
   homepage = "simple lua ansi colors",
   license = "MIT"
}
build = {
   type = "builtin",
   modules = {
      ["luanscol.init"] = "luanscol/init.lua"
   }
}
