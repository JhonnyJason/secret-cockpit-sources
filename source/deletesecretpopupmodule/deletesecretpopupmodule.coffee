deletesecretpopupmodule = {name: "deletesecretpopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["deletesecretpopupmodule"]?  then console.log "[deletesecretpopupmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
popupModule = null
secretSpacePage = null

############################################################
currentClient = null
currentLabel = null

############################################################
deletesecretpopupmodule.initialize = () ->
    log "deletesecretpopupmodule.initialize"
    popupModule = allModules.popupmodule
    secretSpacePage = allModules.secretspacepagemodule

    #deletesecretPopup.
    popupModule.wireUp(deletesecretPopup, applyDeletion)
    return

############################################################
applyDeletion = ->
    log "applyDeletion"
    await currentClient.deleteSecret(currentLabel)
    secretSpacePage.slideIn()
    return

############################################################
deletesecretpopupmodule.deleteSecret = (client, label) ->
    log "deletesecretpopupmodule.addSecret"
    currentClient = client
    currentLabel = label

    deleteLabelLine.textContent = label
    deleteSecretLine.textContent = await client.getSecret(label)
    popupModule.popupForContentElement(deletesecretPopup)
    return

    
module.exports = deletesecretpopupmodule