addsubspacepopupmodule = {name: "addsubspacepopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["addsubspacepopupmodule"]?  then console.log "[addsubspacepopupmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region localModules
utl = null
popupModule = null
secretSpacePage = null

#endregion

############################################################
currentClient = null

############################################################
addsubspacepopupmodule.initialize = () ->
    log "addsubspacepopupmodule.initialize"
    utl = allModules.utilmodule
    popupModule = allModules.popupmodule
    secretSpacePage = allModules.secretspacepagemodule

    #addsubspacePopup.
    popupModule.wireUp(addsubspacePopup, applyAdd)
    return

############################################################
applyAdd = ->
    log "applyAdd"
    id = utl.strip0x(addsubspaceId.textContent)
    await currentClient.acceptSecretsFrom(id)
    secretSpacePage.slideIn()
    return

############################################################
addsubspacepopupmodule.addSubspace = (client) ->
    log "addsubspacepopupmodule.addSubspace"
    currentClient = client

    addsubspaceId.textContent = ""
    popupModule.popupForContentElement(addsubspacePopup)
    return

    
module.exports = addsubspacepopupmodule