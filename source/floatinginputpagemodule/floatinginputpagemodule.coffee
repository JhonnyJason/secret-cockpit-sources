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
clientFactory  = require("secret-manager-client")

############################################################
utl = null
state = null
secretStore = null
slideinModule = null

#endregion

############################################################
currentClient = null

############################################################
floatinginputpagemodule.initialize = () ->
    log "floatinginputpagemodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    secretStore = allModules.clientstoremodule
    slideinModule = allModules.slideinframemodule
    # floatinginputpageContent.
    
    slideinModule.wireUp(floatinginputpageContent, clearContent, applyContent)
    floatingSecretInput.addEventListener("change", secretInputChanged)
    return

############################################################
#region internalFunctions
secretInputChanged = ->
    log "secretInputChanged"
    url = state.get("secretManagerURL")
    seed = floatingSecretInput.value
    secret = await utl.seedToSecret(seed)
    try
        currentClient = await clientFactory.createClient(secret, null, url)
        key = utl.add0x(currentClient.secretKeyHex)
        id = utl.add0x(currentClient.publicKeyHex)
        floatingIdLine.textContent = id
    catch err then log err
    return


############################################################
clearContent = ->
    log "clearContent"
    floatingSecretInput.value = ""
    floatingIdLine.textContent = ""
    currentClient = null
    return

applyContent = ->
    log "applyContent"
    secretStore.storeNewClient(currentClient, "floating")
    clearContent()
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