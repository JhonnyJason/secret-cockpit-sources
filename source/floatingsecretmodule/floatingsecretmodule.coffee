floatingsecretmodule = {name: "floatingsecretmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["floatingsecretmodule"]?  then console.log "[floatingsecretmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
floatingsecretmodule.initialize = () ->
    log "floatingsecretmodule.initialize"
    return
    
module.exports = floatingsecretmodule