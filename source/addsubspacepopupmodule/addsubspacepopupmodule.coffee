addsubspacepopupmodule = {name: "addsubspacepopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["addsubspacepopupmodule"]?  then console.log "[addsubspacepopupmodule]: " + arg
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

############################################################
chosenIndex = null
clientElements = null

############################################################
clientTemplate = null
noOptionsLine = "<p>No Easy Click Options!</p>"

#endregion

############################################################
addsubspacepopupmodule.initialize = () ->
    log "addsubspacepopupmodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    popupModule = allModules.popupmodule
    secretSpacePage = allModules.secretspacepagemodule

    clientTemplate = hiddenClientsDisplayTemplate.innerHTML


    #addsubspacePopup.
    popupModule.wireUp(addsubspacePopup, applyAdd)

    addsubspaceId.addEventListener("change", addsubspaceIdChanged)
    return

############################################################
#region internalFunctions
displayOptions = ->
    log "displayOptions"
    addsubspaceId.value = ""
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
    
    if !optionsContent then easyAddOptionsContainer.innerHTML = noOptionsLine
    else easyAddOptionsContainer.innerHTML = optionsContent

    clientElements = easyAddOptionsContainer.getElementsByClassName("clients-display")
    el.addEventListener("click", clientOptionClicked) for el in clientElements

    return

############################################################
applyAdd = ->
    log "applyAdd"
    id = utl.strip0x(addsubspaceId.value)
    return unless id

    await currentClient.acceptSecretsFrom(id)
    secretSpacePage.slideIn()
    return

############################################################
addsubspaceIdChanged = ->
    log "addsubspaceIdChanged"
    id = utl.strip0x(addsubspaceId.value)
    clientsList = state.get("clientsList")
    log id

    for el in clientElements
        index = el.getAttribute("list-index")
        client = clientsList[index].client
        log client.publicKeyHex
        if client.publicKeyHex == utl.strip0x(id)
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
    client = clientsList[chosenIndex].client
    addsubspaceId.value = utl.add0x(client.publicKeyHex)
    return

#endregion

############################################################
addsubspacepopupmodule.addSubspace = (client) ->
    log "addsubspacepopupmodule.addSubspace"
    currentClient = client

    displayOptions()
    
    popupModule.popupForContentElement(addsubspacePopup)
    return

    
module.exports = addsubspacepopupmodule