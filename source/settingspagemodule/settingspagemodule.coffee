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

    ##for debugging    
    # settingspagemodule.slideIn()

    syncSecretManagerURLFromState()
    state.addOnChangeListener("secretManagerURL", syncSecretManagerURLFromState)
    return

############################################################
#region internalFunctions
clearContent = ->
    log "clearContent"
    syncSecretManagerURLFromState()
    return

applyContent = ->
    log "applyContent"
    secretManagerURL = secretManagerInput.value
    state.save("secretManagerURL", secretManagerURL)
    return

############################################################
syncSecretManagerURLFromState = ->
    log "syncSecretManagerURLFromState"
    secretManagerURL = state.load("secretManagerURL")
    settingspagemodule.displaySecretManagerURL(secretManagerURL)
    return

#endregion

############################################################
#region exposedFunctions
settingspagemodule.displaySecretManagerURL = (url) ->
    log "settingspagemodule.displaySecretManager"
    secretManagerInput.value = url
    return

############################################################
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