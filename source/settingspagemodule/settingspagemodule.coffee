settingspagemodule = {name: "settingspagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["settingspagemodule"]?  then console.log "[settingspagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region localModules
state = null
slideinModule = null

#endregion

############################################################
settingspagemodule.initialize = ->
    log "settingspagemodule.initialize"
    state = allModules.statemodule
    slideinModule = allModules.slideinframemodule
    
    # settingspageContent.
    slideinModule.wireUp(settingspageContent, clearContent, applyContent)

    syncSettingsFromState()

    #region addAllEventListeneres
    secretManagerInput.addEventListener("change", secretManagerInputChanged)
    dataManagerInput.addEventListener("change", dataManagerInputChanged)
    storeInUnsafeInput.addEventListener("change", storeInUnsafeInputChanged)
    storeInFloatingInput.addEventListener("change", storeInFloatingInputChanged)
    storeInSignatureInput.addEventListener("change", storeInSignatureInputChanged)
    keyloggerProtectionInput.addEventListener("change", keyloggerProtectionInputChanged)
    storeUnsafeInput.addEventListener("change", storeUnsafeInputChanged)
    autodetectUnsafeInput.addEventListener("change", autodetectUnsafeInputChanged)
    identifyingEndingInput.addEventListener("change", identifyingEndingInputChanged)
    #endregion
    return

############################################################
#region internalFunctions

clearContent = ->
    log "clearContent"
    syncSettingsFromState()
    return

applyContent = ->
    log "applyContent"
    secretManagerURL = secretManagerInput.value
    state.save("secretManagerURL", secretManagerURL)
    keyloggerProtection = keyloggerProtectionInput.checked
    state.save("keyloggerProtection", keyloggerProtection)
    return

############################################################
syncSettingsFromState = ->
    log "syncSecretManagerURLFromState"
    secretManagerURL = state.load("secretManagerURL")
    secretManagerInput.value = secretManagerURL
    dataManagerURL = state.load("dataManagerURL")
    dataManagerInput.value = dataManagerURL

    storeUnsafeInUnsafe = state.load("storeUnsafeInUnsafe")
    storeInUnsafeInput.checked = storeUnsafeInUnsafe
    storeUnsafeInFloating = state.load("storeUnsafeInFloating")
    storeInFloatingInput.checked = storeUnsafeInFloating
    storeUnsafeInSignature = state.load("storeUnsafeInSignature")
    storeInSignatureInput.checked = storeUnsafeInSignature

    keyloggerProtection = state.load("keyloggerProtection")
    keyloggerProtectionInput.checked = keyloggerProtection

    storeUnsafeInLocalStorage = state.load("storeUnsafeInLocalStorage")
    storeUnsafeInput.checked = storeUnsafeInLocalStorage
    autodetectSecrets = state.load("autodetectStoredSecrets")
    autodetectUnsafeInput.checked = storeUnsafeInput

    identifyingEnding = state.load("secretIdentifyingEnding")
    identifyingEndingInput.value = identifyingEnding 
    return

############################################################
#region eventListeners
secretManagerInputChanged = ->
    url = secretManagerInput.value
    url = "https://"+url unless url.indexOf("https://") == 0
    state.save("secretManagerURL", url)
    return

dataManagerInputChanged = ->
    url = dataManagerInput.value
    url = "http://"+url unless url.indexOf("https://") == 0
    state.save("dataManagerURL", url)
    return

storeInUnsafeInputChanged = ->
    checked = storeInUnsafeInput.checked
    state.save("storeUnsafeInUnsafe", checked)
    return

storeInFloatingInputChanged = ->
    checked = storeInFloatingInput.checked
    state.save("storeUnsafeInFloating", checked)
    return

storeInSignatureInputChanged = ->
    checked = storeInSignatureInput.checked
    state.save("storeUnsafeInSignature", checked)
    return

keyloggerProtectionInputChanged = ->
    checked = keyloggerProtectionInput.checked
    state.save("keyloggerProtection", checked)
    return

storeUnsafeInputChanged = ->
    checked = storeUnsafeInput.checked
    state.save("storeUnsafeInLocalStorage", checked)
    return

autodetectUnsafeInputChanged = ->
    checked = autodetectUnsafeInput.checked
    state.save("autodetectStoredSecrets", checked)
    return

identifyingEndingInputChanged = ->
    value = identifyingEndingInput.value
    state.save("secretIdentifyingEnding", value)
    return

#endregion

#endregion

############################################################
#region exposedFunctions
settingspagemodule.slideOut = ->
    log "settingspagemodule.slideOut"
    slideinModule.slideoutForContentElement(settingspageContent)
    return

settingspagemodule.slideIn = ->
    log "settingspagemodule.slideIn"
    slideinModule.slideinForContentElement(settingspageContent)
    return

#endregion

module.exports = settingspagemodule

# MasterSecret Id? 0x19e23357ad9464ba664344cf661d15a25bcc2874be497940c11b7573cd773b13