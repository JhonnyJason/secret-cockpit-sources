unsafeinputpagemodule = {name: "unsafeinputpagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["unsafeinputpagemodule"]?  then console.log "[unsafeinputpagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region localModules
clientFactory  = require("secret-manager-client")

############################################################
state = null
slideinModule = null

#endregion

############################################################
unsafeinputpagemodule.initialize = ->
    log "unsafeinputpagemodule.initialize"
    state = allModules.statemodule
    slideinModule = allModules.slideinframemodule
    # unsafeinputpageContent.
    slideinModule.wireUp(unsafeinputpageContent, clearContent, applyContent)

    createUnsafeButton.addEventListener("click", createUnsafeButtonClicked)
    scanQrButton.addEventListener("click", scanQrButtonClicked)
    return

############################################################
#region internalFunctions
createUnsafeButtonClicked = ->
    log "createUnsafeButtonClicked"
    url = state.get("secretManagerURL")
    newClient = await clientFactory.createClient(null, null, url)
    unsafeSecretInput.value = newClient.secretKeyHex
    return

scanQrButtonClicked = ->
    log "scanQrButtonClicked"
    return

############################################################
clearContent = ->
    log "clearContent"
    unsafeSecretInput.value = "0xdeadbeefdeadbeefdeadbeefdeadbeef"
    return

applyContent = ->
    log "applyContent"
    # TODO
    return

#endregion

############################################################
#region exposedFunctions
unsafeinputpagemodule.slideOut = ->
    log "unsafeinputpagemodule.slideOut"
    slideinModule.slideoutForContentElement(unsafeinputpageContent)
    return

unsafeinputpagemodule.slideIn = ->
    log "unsafeinputpagemodule.slideIn"
    slideinModule.slideinForContentElement(unsafeinputpageContent)
    return

#endregion

module.exports = unsafeinputpagemodule