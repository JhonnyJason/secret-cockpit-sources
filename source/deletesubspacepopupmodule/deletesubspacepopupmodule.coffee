deletesubspacepopupmodule = {name: "deletesubspacepopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["deletesubspacepopupmodule"]?  then console.log "[deletesubspacepopupmodule]: " + arg
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
currentSubspaceId = null

############################################################
deletesubspacepopupmodule.initialize = () ->
    log "deletesubspacepopupmodule.initialize"
    utl = allModules.utilsmodule
    popupModule = allModules.popupmodule
    secretSpacePage = allModules.secretspacepagemodule

    #deletesubspacePopup.
    popupModule.wireUp(deletesubspacePopup, applyDeletion)
    return

############################################################
applyDeletion = ->
    log "applyDeletion"
    await currentClient.stopAcceptSecretsFrom(currentSubspaceId)
    secretSpacePage.slideIn()
    return

############################################################
deletesubspacepopupmodule.deleteSubspace = (client, id) ->
    log "deletesubspacepopupmodule.deleteSubspace"
    currentClient = client
    currentSubspaceId = id

    deletesubspaceId.textContent = utl.add0x(id)
    popupModule.popupForContentElement(deletesubspacePopup)
    return

    
module.exports = deletesubspacepopupmodule