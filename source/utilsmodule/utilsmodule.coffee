utilsmodule = {name: "utilsmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["utilsmodule"]?  then console.log "[utilsmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

secUtl = require("secret-manager-crypto-utils")
Object.assign(utilsmodule, secUtl)

msgBox = require("./messageboxmodule")

############################################################
utilsmodule.add0x = (hex) ->
    if !hex? then throw new Error("add0x - undefined argument!")
    return hex unless hex[0] != "0" or hex[1] != "x"
    return "0x"+hex

utilsmodule.strip0x = (hex) ->
    if !hex? then throw new Error("strip0x - undefined argument!")
    return hex unless hex[0] == "0" and hex[1] == "x"
    return hex.slice(2)

############################################################
utilsmodule.idOrAlias = (id) ->
    alias = allModules.idaliasmodule.aliasFrom(id)
    if alias then return alias
    else return utilsmodule.add0x(id)

############################################################
utilsmodule.seedToKey = (seed) ->
    hashHex = await secUtl.sha512Hex(seed)
    shift = parseInt(hashHex[0], 16) * 2
    return hashHex.substr(shift, 64)

############################################################
utilsmodule.copyToClipboard = (text) ->
    try 
        await navigator.clipboard.writeText(text)
        log "Clipboard API succeeded"
        if msgBox? then msgBox.info("Copied: "+text)
        return
    catch err then log err

    ## Oldschool Method
    ## create element to select from
    copyElement = document.createElement("textarea")
    copyElement.value = text
    copyElement.setAttribute("readonly", "")

    #have element available but not visible
    copyElement.style.position = "absolute"
    copyElement.style.left = "-99999px"
    document.body.appendChild(copyElement)
    
    #select text to copy
    document.getSelection().removeAllRanges()
    copyElement.select()
    copyElement.setSelectionRange(0, 99999)
    document.execCommand("copy")

    #remove element again
    document.body.removeChild(copyElement)
    if msgBox? then msgBox.info("Copied: "+text)
    return


module.exports = utilsmodule