storesecretpopupmodule = {name: "storesecretpopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["storesecretpopupmodule"]?  then console.log "[storesecretpopupmodule]: " + arg
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

############################################################
noStoreOptionsLine = "<p>No Options to Store the Secret!</p>"

############################################################
storesecretpopupmodule.initialize = ->
    log "storesecretpopupmodule.initialize"
    popupModule = allModules.popupmodule

    #storesecretPopup.
    popupModule.wireUp(storesecretPopup, applyStore)
    return

############################################################
displayStoreOptions = ->
    log "displayStoreOptions"
    optionsContent = ""

    ## TODO clientStore - getSecretStoreOptionClients
    ## create clickable HTML element for all of them

    
    if !optionsContent then storesecretOptionsContainer.innerHTML = noStoreOptionsLine
    else storesecretOptionsContainer.innerHTML = optionsContent
    return


applyStore = ->
    log "applyStore"
    currentSecret = await currentClient.getSecret(currentSecretId)
    chosenClientIndex = state.get("chosen-client-index")
    # storeClient = getClientByIndex(chosenClientIndex)

    newSecretId = storesecretAsLine.textContent
    if !newSecretId then return

    # await storeClient.setSecret(newSecretId, currentSecret)
    return

############################################################
storesecretpopupmodule.storeSecret = (client, secretId) ->
    log "storesecretpopupmodule.storeSecret"
    currentClient = client
    currentSecretId = secretId

    storesecretIdLine.textContent = currentSecretId
    storesecretAsLine.textContent = currentSecretId

    displayStoreOptions()

    popupModule.popupForContentElement(storesecretPopup)
    return

    
module.exports = storesecretpopupmodule