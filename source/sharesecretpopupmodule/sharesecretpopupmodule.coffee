sharesecretpopupmodule = {name: "sharesecretpopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["sharesecretpopupmodule"]?  then console.log "[sharesecretpopupmodule]: " + arg
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
msgBox = null
popupModule = null

#endregion

############################################################
#region internalProperties
currentClient = null
currentFromId = null
currentSecretId = null

############################################################
chosenIndex = null
clientElements = null

############################################################
clientTemplate = null
noshareOptionsLine = "<p>No Options to share the Secret!</p>"

#endregion

############################################################
sharesecretpopupmodule.initialize = ->
    log "sharesecretpopupmodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    msgBox = allModules.messageboxmodule
    popupModule = allModules.popupmodule
    clientTemplate = hiddenClientsDisplayTemplate.innerHTML

    #sharesecretPopup.
    popupModule.wireUp(sharesecretPopup, applyShare)

    sharesecretToIdLine.addEventListener("change", sharesecretToIdLineChanged)
    return

############################################################
#region internalFunctions
displayShareOptions = ->
    log "displayShareOptions"
    sharesecretToIdLine.value = ""
    optionsContent = ""
    clientsList = state.get("clientsList")
    return unless clientsList?

    cObj = {}
    count = 0
    for obj,i in clientsList
        cObj.index = i
        cObj.type = obj.type
        cObj.label = utl.idOrAlias(obj.client.publicKeyHex)
        optionsContent += mustache.render(clientTemplate, cObj)
        count++
    
    if !optionsContent then sharesecretOptionsContainer.innerHTML = noshareOptionsLine
    else sharesecretOptionsContainer.innerHTML = optionsContent

    clientElements = sharesecretOptionsContainer.getElementsByClassName("clients-display")
    el.addEventListener("click", clientOptionClicked) for el in clientElements

    if count ==  1 then selectClientFor(clientElements[0])
    return


############################################################
applyShare = ->
    log "applyShare"
    return unless chosenIndex?
    
    clientsList = state.get("clientsList")
    shareToId = clientsList[chosenIndex].client.publicKeyHex
    try
        secret = await currentClient.getSecret(currentSecretId)
        await currentClient.shareSecretTo(shareToId, currentSecretId, secret)
    catch err
        try await currentClient.deleteSharedSecret(shareToId, currentSecretId)
        catch err
        msgBox.error("Failed to share secret!")
        log err
    return


############################################################
sharesecretToIdLineChanged = ->
    log "sharesecretToIdLineChanged"
    shareToId = utl.strip0x(sharesecretToIdLine.value)
    clientsList = state.get("clientsList")
    log shareToId

    for el in clientElements
        index = el.getAttribute("list-index")
        client = clientsList[index].client
        log client.publicKeyHex
        if client.publicKeyHex == utl.strip0x(shareToId)
            selectClientFor(el)
            return

    selectClientFor(null)
    return

clientOptionClicked = (evt) ->
    log "clientOptionClicked"
    selectClientFor(evt.target)
    return

selectClientFor = (el) ->
    log "selectClientFor"
    chosenClientIndex = null
    client.classList.remove("selected") for client in clientElements
    return unless el?
    chosenIndex = parseInt(el.getAttribute("list-index"))
    el.classList.add("selected")

    clientsList = state.get("clientsList")
    shareClient = clientsList[chosenIndex].client
    sharesecretToIdLine.value = utl.add0x(shareClient.publicKeyHex)
    return

#endregion

############################################################
sharesecretpopupmodule.shareSecret = (client, secretId) ->
    log "sharesecretpopupmodule.shareSecret"
    currentClient = client
    currentSecretId = secretId
    chosenIndex  = null

    sharesecretIdLine.textContent = currentSecretId

    displayShareOptions()

    popupModule.popupForContentElement(sharesecretPopup)
    return

    
module.exports = sharesecretpopupmodule