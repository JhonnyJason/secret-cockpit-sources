unsafesecretmodule = {name: "unsafesecretmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["unsafesecretmodule"]?  then console.log "[unsafesecretmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
unsafesecretmodule.initialize = () ->
    log "unsafesecretmodule.initialize"
    return
    
module.exports = unsafesecretmodule