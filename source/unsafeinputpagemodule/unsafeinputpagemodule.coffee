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
clientStore = null
autoDetect = null
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
    clientStore = allModules.clientstoremodule
    autoDetect = allModules.autodetectkeysmodule
    slideinModule = allModules.slideinframemodule
    qrReader = allModules.qrreadermodule

    # unsafeinputpageContent.
    slideinModule.wireUp(unsafeinputpageContent, clearContent, applyContent)

    createUnsafeButton.addEventListener("click", createUnsafeButtonClicked)
    scanQrButton.addEventListener("click", scanQrButtonClicked)

    unsafeKeyInput.addEventListener("change", secretInputChanged)
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
        unsafeKeyInput.value = key
        unsafeIdLine.textContent = id
    catch err then log err
    return

scanQrButtonClicked = ->
    log "scanQrButtonClicked"
    data = await qrReader.read()
    return unless data?
    url = state.get("secretManagerURL")
    try
        currentClient = await clientFactory.createClient(data, null, url)
        key = utl.add0x(currentClient.secretKeyHex)
        id = utl.add0x(currentClient.publicKeyHex)
        unsafeKeyInput.value = key
        unsafeIdLine.textContent = id
    catch err then log err
    return

secretInputChanged = ->
    log "secretInputChanged"
    url = state.get("secretManagerURL")
    key = utl.strip0x(unsafeKeyInput.value)
    try
        currentClient = await clientFactory.createClient(key, null, url)
        key = utl.add0x(currentClient.secretKeyHex)
        id = utl.add0x(currentClient.publicKeyHex)
        unsafeKeyInput.value = key
        unsafeIdLine.textContent = id
    catch err then log err
    return

############################################################
clearContent = ->
    log "clearContent"
    unsafeKeyInput.value = "0xdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"
    unsafeIdLine.textContent = ""
    currentClient = null
    return

applyContent = ->
    log "applyContent"
    clientStore.storeNewClient(currentClient, "unsafe")
    autoDetect.detectFor(currentClient)
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