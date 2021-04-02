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
utl = null
state = null
secretStore = null
slideinModule = null
qrReader = null

#endregion

############################################################
currentClient = null

############################################################
unsafeinputpagemodule.initialize = ->
    log "unsafeinputpagemodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    secretStore = allModules.clientstoremodule
    slideinModule = allModules.slideinframemodule
    qrReader = allModules.qrreadermodule

    # unsafeinputpageContent.
    slideinModule.wireUp(unsafeinputpageContent, clearContent, applyContent)

    createUnsafeButton.addEventListener("click", createUnsafeButtonClicked)
    scanQrButton.addEventListener("click", scanQrButtonClicked)

    unsafeSecretInput.addEventListener("change", secretInputChanged)
    return

############################################################
#region internalFunctions
createUnsafeButtonClicked = ->
    log "createUnsafeButtonClicked"
    url = state.get("secretManagerURL")
    try
        currentClient = await clientFactory.createClient(null, null, url)
        key = utl.add0x(currentClient.secretKeyHex)
        id = utl.add0x(currentClient.publicKeyHex)
        unsafeSecretInput.value = key
        unsafeIdLine.textContent = id
    catch err then log err
    return

scanQrButtonClicked = ->
    log "scanQrButtonClicked"
    data = qrReader.read()
    return

secretInputChanged = ->
    log "secretInputChanged"
    url = state.get("secretManagerURL")
    secret = utl.strip0x(unsafeSecretInput.value)
    try
        currentClient = await clientFactory.createClient(secret, null, url)
        key = utl.add0x(currentClient.secretKeyHex)
        id = utl.add0x(currentClient.publicKeyHex)
        unsafeSecretInput.value = key
        unsafeIdLine.textContent = id
    catch err then log err
    return


############################################################
clearContent = ->
    log "clearContent"
    unsafeSecretInput.value = "0xdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    unsafeIdLine.textContent = ""
    currentClient = null
    return

applyContent = ->
    log "applyContent"
    secretStore.storeNewClient(currentClient, "unsafe")
    clearContent()
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