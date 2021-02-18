utilmodule = {name: "utilmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["utilmodule"]?  then console.log "[utilmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

secUtl = require("secret-manager-crypto-utils")
Object.assign(utilmodule, secUtl)

############################################################
utilmodule.add0x = (hex) ->
    if !hex? then throw new Error("add0x - undefined argument!")
    return hex unless hex[0] != "0" or hex[1] != "x"
    return "0x"+hex

utilmodule.strip0x = (hex) ->
    if !hex? then throw new Error("strip0x - undefined argument!")
    return hex unless hex[0] == "0" and hex[1] == "x"
    return hex.slice(2)

############################################################
utilmodule.seedToSecret = (seed) ->
    hashHex = await secUtl.sha512Hex(seed)
    shift = parseInt(hashHex[0], 16) * 2
    return hashHex.substr(shift, 64)


module.exports = utilmodule