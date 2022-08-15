storeidpopupmodule = {name: "storeidpopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["storeidpopupmodule"]?  then console.log "[storeidpopupmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region modulesFromEnvironment
M = require("mustache")

############################################################
utl = null
state = null
popupModule = null

#endregion

############################################################
#region internalProperties
currentClient = null

############################################################
chosenIndex = null
clientElements = null

############################################################
clientTemplate = null
noStoreOptionsLine = "<p>No Options to Store the Id!</p>"

#endregion


############################################################
storeidpopupmodule.initialize = ->
    log "storeidpopupmodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    popupModule = allModules.popupmodule
    clientTemplate = hiddenClientsDisplayTemplate.innerHTML

    #storeidPopup.
    popupModule.wireUp(storeidPopup, applyStore)
    return

############################################################
#region internalFunctions
displayStoreOptions = ->
    log "displayStoreOptions"
    optionsContent = ""
    clientsList = state.get("clientsList")
    return unless clientsList?

    cObj = {}
    count = 0
    for obj,i in clientsList when obj.client != currentClient
        cObj.index = i
        cObj.type = obj.type
        cObj.label = utl.idOrAlias(obj.client.publicKeyHex)
        optionsContent += M.render(clientTemplate, cObj)
        count++
    
    if !optionsContent then storeidOptionsContainer.innerHTML = noStoreOptionsLine
    else storeidOptionsContainer.innerHTML = optionsContent

    clientElements = storeidOptionsContainer.getElementsByClassName("clients-display")
    el.addEventListener("click", clientOptionClicked) for el in clientElements

    if count ==  1 then selectClientFor(clientElements[0])
    return


############################################################
clientOptionClicked = (evt) ->
    log "clientOptionClicked"
    selectClientFor(evt.target)
    return

selectClientFor = (el) ->
    log "selectClientFor"
    chosenIndex = parseInt(el.getAttribute("list-index"))
    client.classList.remove("selected") for client in clientElements
    el.classList.add("selected")
    return

############################################################
applyStore = ->
    log "applyStore"
    return unless chosenIndex?
    clientsList = state.get("clientsList")
    storeClient = clientsList[chosenIndex].client

    newSecretId = storeidAsLine.textContent
    if !newSecretId then return

    await storeClient.setSecret(newSecretId, currentClient.publicKeyHex)
    return

#endregion

############################################################
storeidpopupmodule.storeId = (client) ->
    log "storeidpopupmodule.storeSecret"
    currentClient = client
    chosenIndex  = null
    identifier = state.get("secretIdentifyingEnding")
    id = client.publicKeyHex

    storeidLine.textContent = utl.add0x(id)
    storeidAsLine.textContent = utl.idOrAlias(id) + "Id"

    displayStoreOptions()

    popupModule.popupForContentElement(storeidPopup)
    return

    
module.exports = storeidpopupmodule