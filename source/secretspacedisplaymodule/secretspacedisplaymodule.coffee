secretspacedisplaymodule = {name: "secretspacedisplaymodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["secretspacedisplaymodule"]?  then console.log "[secretspacedisplaymodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
secretspacedisplaymodule.initialize = () ->
    log "secretspacedisplaymodule.initialize"
    return
    
module.exports = secretspacedisplaymodule