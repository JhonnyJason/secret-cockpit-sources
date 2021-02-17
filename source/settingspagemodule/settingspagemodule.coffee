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
#region localMOdules
state = null
slideinModule = null

#endregion

############################################################
settingspagemodule.initialize = () ->
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
    keyloggerProtection = state.load("keyloggerProtection")
    keyloggerProtectionInput.checked = keyloggerProtection
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