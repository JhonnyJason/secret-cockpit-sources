editsecretpopupmodule = {name: "editsecretpopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["editsecretpopupmodule"]?  then console.log "[editsecretpopupmodule]: " + arg
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
currentSecret = null

############################################################
editsecretpopupmodule.initialize = ->
    log "editsecretpopupmodule.initialize"
    popupModule = allModules.popupmodule
    secretSpacePage = allModules.secretspacepagemodule

    #editsecretPopup.
    popupModule.wireUp(editsecretPopup, applyEdit)
    return
    
############################################################
applyEdit = ->
    log "applyEdit"
    newSecretId = editSecretIdLine.textContent
    if !newSecretId then return
    if newSecretId != currentSecretId then currentClient.deleteSecret(currentSecretId)

    newSecret = editSecretLine.textContent

    if newSecret != currentSecret then await currentClient.setSecret(newSecretId, newSecret)
    secretSpacePage.slideIn()
    return


############################################################
editsecretpopupmodule.editSecret = (client, secretId) ->
    log "editsecretpopupmodule.editSecret"
    log secretId
    currentSecret = await client.getSecret(secretId)
    currentClient = client
    currentSecretId = secretId

    editSecretIdLine.textContent = secretId
    editSecretLine.textContent = currentSecret
    popupModule.popupForContentElement(editsecretPopup)
    return


module.exports = editsecretpopupmodule