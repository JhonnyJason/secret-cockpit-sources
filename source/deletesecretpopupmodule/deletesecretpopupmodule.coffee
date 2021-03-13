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
currentSecretId = null

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
    await currentClient.deleteSecret(currentSecretId)
    secretSpacePage.slideIn()
    return

############################################################
deletesecretpopupmodule.deleteSecret = (client, secretId) ->
    log "deletesecretpopupmodule.addSecret"
    currentClient = client
    currentSecretId = secretId

    deleteSecretIdLine.textContent = secretId
    deleteSecretLine.textContent = await client.getSecret(secretId)
    popupModule.popupForContentElement(deletesecretPopup)
    return

    
module.exports = deletesecretpopupmodule