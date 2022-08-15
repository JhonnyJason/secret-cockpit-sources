############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("aliaspagemodule")
#endregion

############################################################
#region localModules
import M from "mustache"

############################################################
import * as aliasModule from  "./idaliasmodule.js"
import * as utl from "./utilsmodule.js"
import * as state from "./statemodule.js"
import * as addAliasPopup from "./addaliaspopupmodule.js"
import * as slideinModule from "./slideinframemodule.js"

#endregion

############################################################
aliasTemplate = null
noIdsElement = "<p>No Ids available yet :-)</p>"

############################################################
export initialize = ->
    log "initialize"
    aliasTemplate = hiddenAliasTemplate.innerHTML

    # aliaspageContent.
    slideinModule.wireUp(aliaspageContent, clearContent, applyContent)

    addAliasButton.addEventListener("click", addAliasButtonClicked)
    return
    
############################################################
#region internalFunctions
syncAliasesFromState = ->
    log "syncAliasesFromState"
    content = ""
    clientsList = state.get("clientsList")
    idsWithAlias = aliasModule.getAllIds()

    if !clientsList? then allIds = idsWithAlias
    else
        allClientsObject = {}
        clientsList.forEach((el) -> allClientsObject[el.client.publicKeyHex] = true)
        idsWithAlias.forEach((id) -> allClientsObject[id] = true)
        allIds = Object.keys(allClientsObject) 

    cObj = {}
    for id in allIds
        cObj.id = utl.add0x(id)
        cObj.alias = aliasModule.aliasFrom(id)
        if !cObj.alias? then cObj.alias = ""
        content += M.render(aliasTemplate, cObj)

    if content then aliasContainer.innerHTML = content
    else aliasContainer.innerHTML = noIdsElement
    return

getIdAliasPair = (el) ->
    id = utl.strip0x(el.getAttribute("alias-id"))
    alias = el.getElementsByClassName("alias-label")[0].textContent
    return {id, alias}

syncAliasesToState = ->
    log "syncAliasesToState"
    aliases = aliasContainer.getElementsByClassName("alias")
    aliasPairs = Array.from(aliases, getIdAliasPair)
    aliasModule.applyAliases(aliasPairs)
    return

############################################################
addAliasButtonClicked = ->
    log "addAliasButtonClicked"
    addAliasPopup.addAlias()
    return

############################################################
clearContent = ->
    log "clearContent"
    return

applyContent = ->
    log "applyContent"
    syncAliasesToState()
    return

#endregion

############################################################
#region exposedFunctions
export slideOut = ->
    log "aliaspagemodule.slideOut"
    slideinModule.slideoutForContentElement(aliaspageContent)
    return

export slideIn = ->
    log "aliaspagemodule.slideIn"
    syncAliasesFromState()
    slideinModule.slideinForContentElement(aliaspageContent)
    return
