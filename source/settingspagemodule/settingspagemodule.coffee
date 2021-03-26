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
    return

############################################################
#region internalFunctions

clearContent = ->
    log "clearContent"
    syncSettingsFromState()
    return

applyContent = ->
    log "applyContent"
    syncSettingsToState()
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

syncSettingsToState = ->
    log "syncSettingsToState"
    ## Secret Manager URL
    url = secretManagerInput.value
    url = "https://"+url unless url.indexOf("https://") == 0
    state.set("secretManagerURL", url)
    ## Data Manager URL
    url = dataManagerInput.value
    url = "http://"+url unless url.indexOf("https://") == 0
    state.set("dataManagerURL", url)

    ## Key Storing Options
    checked = storeInUnsafeInput.checked
    state.set("storeUnsafeInUnsafe", checked)
    checked = storeInFloatingInput.checked
    state.set("storeUnsafeInFloating", checked)
    checked = storeInSignatureInput.checked
    state.set("storeUnsafeInSignature", checked)

    ## KeyLogger Protection
    checked = keyloggerProtectionInput.checked
    state.set("keyloggerProtection", checked)

    ## Store Unsafe Secret in LocalStorage
    checked = storeUnsafeInput.checked
    state.set("storeUnsafeInLocalStorage", checked)

    ## Autodetect Stored Secrets
    checked = autodetectUnsafeInput.checked
    state.set("autodetectStoredSecrets", checked)

    ## Ending which identifies a stored Secret
    value = identifyingEndingInput.value
    state.save("secretIdentifyingEnding", value)
    ## As all Settings are in the regular State
    ## We only have to call the save method once
    ## And all the regular state is stored in localStorage :-)
    return


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