############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("clientsdisplaymodule")
#endregion

############################################################
#region imports
import M from "mustache"

############################################################
import * as state from "./statemodule.js"
import * as utl from "./utilsmodule.js"

#endregion

############################################################
template = null
emptyContainerElement ="<p>No Known Account here :-)</p>"

############################################################
export initialize = ->
    log "clientsdisplaymodule.initialize"
    template = hiddenClientsDisplayTemplate.innerHTML

    displayAllKnownClients()
    state.addOnChangeListener("aliasToId", displayAllKnownClients)
    state.addOnChangeListener("clientsList", displayAllKnownClients)
    aliasPageButton.addEventListener("click", aliasPageButtonClicked)
    return
    
############################################################
#region internal functions
displayAllKnownClients = ->
    log "displayAllKnownClients"
    clientsList = state.get("clientsList")
    return unless clientsList?

    cObj = {}
    content = ""
    for obj,i in clientsList
        cObj.index = i
        cObj.type = obj.type
        cObj.label = utl.idOrAlias(obj.client.publicKeyHex)        
        content += mustache.render(template, cObj)

    if content then clientsDisplayContainer.innerHTML = content
    else clientsDisplayContainer.innerHTML = emptyContainerElement

    clients = clientsDisplayContainer.getElementsByClassName("clients-display")
    client.addEventListener("click", clientDisplayClicked) for client in clients
    return

############################################################
aliasPageButtonClicked = ->
    log "aliasPageButtonClicked"
    allModules.aliaspagemodule.slideIn()
    return

clientDisplayClicked = (evt) ->
    log "clientDisplayClicked"
    index = parseInt(evt.target.getAttribute("list-index"))
    state.set("chosenClientIndex", index)
    allModules.secretspacepagemodule.slideIn()
    return

#endregion