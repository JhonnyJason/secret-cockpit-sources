messageboxmodule = {name: "messageboxmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["messageboxmodule"]?  then console.log "[messageboxmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
messageboxmodule.initialize = () ->
    log "messageboxmodule.initialize"
    return
    
module.exports = messageboxmodule