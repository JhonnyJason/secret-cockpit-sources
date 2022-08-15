############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("addsubspacepopupmodule")
#endregion


############################################################
#region modulesFromEnvironment
import M from "mustache"

############################################################
import * as utl from "./utilsmodule.js"
import * as state from "./statemodule.js"
import * as popupModule from "./popupmodule.js"
import * as secretSpacePage from "./secretspacepagemodule"

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
initialize = ->
    log "initialize"
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
        optionsContent += M.render(clientTemplate, cObj)
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
export addSubspace = (client) ->
    log "addsubspacepopupmodule.addSubspace"
    currentClient = client

    displayOptions()
    
    popupModule.popupForContentElement(addsubspacePopup)
    return

