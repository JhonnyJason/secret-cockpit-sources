signatureinputpagemodule = {name: "signatureinputpagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["signatureinputpagemodule"]?  then console.log "[signatureinputpagemodule]: " + arg
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
signatureinputpagemodule.initialize = ->
    log "signatureinputpagemodule.initialize"
    state = allModules.statemodule
    slideinModule = allModules.slideinframemodule
    # signatureinputpageContent.
    slideinModule.wireUp(signatureinputpageContent, clearContent, applyContent)
    return

############################################################
#region internalFunctions
clearContent = ->
    log "clearContent"
    signatureKeyInput.value = "I am a funny seed message :-)"
    return

applyContent = ->
    log "applyContent"
    # TODO
    return

#endregion

############################################################
#region exposedFunctions
signatureinputpagemodule.slideOut = ->
    log "signatureinputpagemodule.slideOut"
    slideinModule.slideoutForContentElement(signatureinputpageContent)
    return

signatureinputpagemodule.slideIn = ->
    log "signatureinputpagemodule.slideIn"
    slideinModule.slideinForContentElement(signatureinputpageContent)
    return

#endregion

module.exports = signatureinputpagemodule