storeunsafepopupmodule = {name: "storeunsafepopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["storeunsafepopupmodule"]?  then console.log "[storeunsafepopupmodule]: " + arg
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

#endregion

############################################################
#region internalProperties
currentClient = null

############################################################
chosenIndex = null
clientElements = null

############################################################
clientTemplate = null
noStoreOptionsLine = "<p>No Options to Store the Unsafe Secret!</p>"

#endregion


############################################################
storeunsafepopupmodule.initialize = ->
    log "storeunsafepopupmodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    popupModule = allModules.popupmodule
    clientTemplate = hiddenClientsDisplayTemplate.innerHTML

    #storeunsafePopup.
    popupModule.wireUp(storeunsafePopup, applyStore)
    return

############################################################
#region internalFunctions
displayStoreOptions = ->
    log "displayStoreOptions"
    optionsContent = ""
    clientsList = state.get("clientsList")
    return unless clientsList?

    inUnsafe = state.get("storeUnsafeInUnsafe")
    inFloating = state.get("storeUnsafeInFloating")
    inSignature = state.get("storeUnsafeInSignature")

    cObj = {}
    count = 0
    if state.get("storeUnsafeInFloating")
        for obj,i in clientsList when obj.client != currentClient
            switch obj.type
                when "unsafe" then continue unless inUnsafe
                when "floating" then continue unless inFloating
                when "signature" then continue unless inSignature
            cObj.index = i
            cObj.type = obj.type
            cObj.id = utl.add0x(obj.client.publicKeyHex)        
            optionsContent += mustache.render(clientTemplate, cObj)
            count++
    
    if !optionsContent then storeunsafeOptionsContainer.innerHTML = noStoreOptionsLine
    else storeunsafeOptionsContainer.innerHTML = optionsContent

    clientElements = storeunsafeOptionsContainer.getElementsByClassName("clients-display")
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

    newSecretId = storeunsafeAsLine.textContent
    if !newSecretId then return

    await storeClient.setSecret(newSecretId, currentClient.secretKeyHex)
    return

#endregion

############################################################
storeunsafepopupmodule.storeUnsafe = (client) ->
    log "storeunsafepopupmodule.storeSecret"
    currentClient = client
    chosenIndex  = null
    identifier = state.get("secretIdentifyingEnding")

    storeunsafeIdLine.textContent = utl.add0x(client.publicKeyHex)
    storeunsafeAsLine.textContent = utl.add0x(client.publicKeyHex) + identifier

    displayStoreOptions()

    popupModule.popupForContentElement(storeunsafePopup)
    return

    
module.exports = storeunsafepopupmodule