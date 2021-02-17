floatinginputpagemodule = {name: "floatinginputpagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["floatinginputpagemodule"]?  then console.log "[floatinginputpagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region localMOdules
state = null
slideinModule = null

#endregion

############################################################
floatinginputpagemodule.initialize = () ->
    log "floatinginputpagemodule.initialize"
    state = allModules.statemodule
    slideinModule = allModules.slideinframemodule
    # floatinginputpageContent.
    slideinModule.wireUp(floatinginputpageContent, clearContent, applyContent)
    return

############################################################
#region internalFunctions
clearContent = ->
    log "clearContent"
    floatingSecretInput.value = ""
    return

applyContent = ->
    log "applyContent"
    # TODO
    return

#endregion

############################################################
#region exposedFunctions
floatinginputpagemodule.slideOut = ->
    log "floatinginputpagemodule.slideOut"
    slideinModule.slideoutForContentElement(floatinginputpageContent)
    return

floatinginputpagemodule.slideIn = ->
    log "floatinginputpagemodule.slideIn"
    slideinModule.slideinForContentElement(floatinginputpageContent)
    return

#endregion

module.exports = floatinginputpagemodule