qrdisplaymodule = {name: "qrdisplaymodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["qrdisplaymodule"]?  then console.log "[qrdisplaymodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion



############################################################
qrdisplaymodule.initialize = ->
    log "qrdisplaymodule.initialize"
    return


############################################################
qrdisplaymodule.displayCode = (information) ->
    log "qrdisplaymodule.displayCode"
    log information

    return

module.exports = qrdisplaymodule