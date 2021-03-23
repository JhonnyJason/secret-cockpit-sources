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
#region modulesFromEnvironment
mustache = require("mustache")

############################################################
utl = null
state = null
popupModule = null
secretSpacePage = null

#endregion

############################################################
#region internalProperties
currentClient = null
currentSecretId = null

############################################################
chosenIndex = null
clientElements = null

############################################################
clientTemplate = null
noStoreOptionsLine = "<p>No Options to Store the Secret!</p>"

#endregion


############################################################
storesecretpopupmodule.initialize = ->
    log "storesecretpopupmodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    popupModule = allModules.popupmodule
    clientTemplate = hiddenClientsDisplayTemplate.innerHTML

    #storesecretPopup.
    popupModule.wireUp(storesecretPopup, applyStore)
    return

############################################################
displayStoreOptions = ->
    log "displayStoreOptions"
    optionsContent = ""
    clientsList = state.get("clientsList")
    return unless clientsList?

    cObj = {}
    count = 0
    if state.get("storeUnsafeInFloating")
        for obj,i in clientsList when obj.client != currentClient
            switch obj.type
                when "unsafe" then continue unless state.get("storeUnsafeInUnsafe")
                when "floating" then continue unless state.get("storeUnsafeInFloating")
                when "signature" then continue unless state.get("storeUnsafeInSignature")
            cObj.index = i
            cObj.type = obj.type
            cObj.id = utl.add0x(obj.client.publicKeyHex)        
            optionsContent += mustache.render(clientTemplate, cObj)
            count++
    
    if !optionsContent then storesecretOptionsContainer.innerHTML = noStoreOptionsLine
    else storesecretOptionsContainer.innerHTML = optionsContent

    clientElements = storesecretOptionsContainer.getElementsByClassName("clients-display")
    el.addEventListener("click", clientOptionClicked) for el in clientElements

    if count ==  1 then selectClientFor(clientElements[0])
    return


applyStore = ->
    log "applyStore"
    return unless chosenIndex?
    currentSecret = await currentClient.getSecret(currentSecretId)
    clientsList = state.get("clientsList")
    storeClient = clientsList[chosenIndex].client

    newSecretId = storesecretAsLine.textContent
    if !newSecretId then return

    await storeClient.setSecret(newSecretId, currentSecret)
    return


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
storesecretpopupmodule.storeSecret = (client, secretId) ->
    log "storesecretpopupmodule.storeSecret"
    currentClient = client
    currentSecretId = secretId
    chosenIndex  = null

    storesecretIdLine.textContent = currentSecretId
    storesecretAsLine.textContent = currentSecretId

    displayStoreOptions()

    popupModule.popupForContentElement(storesecretPopup)
    return

    
module.exports = storesecretpopupmodule