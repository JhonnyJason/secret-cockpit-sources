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
currentLabel = null
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
    newLabel = editLabelLine.textContent
    if !newLabel then return
    if newLabel != currentLabel then currentClient.deleteSecret(currentLabel)

    newSecret = editSecretLine.textContent
    if newSecret != currentSecret then await currentClient.setSecret(newLabel, newSecret)
    secretSpacePage.slideIn()
    return


############################################################
editsecretpopupmodule.editSecret = (client, label) ->
    log "editsecretpopupmodule.editSecret"
    currentSecret = await client.getSecret(label)
    currentClient = client
    currentLabel = label

    editLabelLine.textContent = label
    editSecretLine.textContent = currentSecret
    popupModule.popupForContentElement(editsecretPopup)
    return


module.exports = editsecretpopupmodule