aliaspagemodule = {name: "aliaspagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["aliaspagemodule"]?  then console.log "[aliaspagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region localModules
mustache = require("mustache")

############################################################
aliasModule = null
utl = null
state = null
addAliasPopup = null
slideinModule = null

#endregion

############################################################
aliasTemplate = null
noIdsElement = "<p>No Ids available yet :-)</p>"

############################################################
aliaspagemodule.initialize = ->
    log "aliaspagemodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    aliasModule = allModules.idaliasmodule
    addAliasPopup = allModules.addaliaspopupmodule
    slideinModule = allModules.slideinframemodule

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
        content += mustache.render(aliasTemplate, cObj)

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
aliaspagemodule.slideOut = ->
    log "aliaspagemodule.slideOut"
    slideinModule.slideoutForContentElement(aliaspageContent)
    return

aliaspagemodule.slideIn = ->
    log "aliaspagemodule.slideIn"
    syncAliasesFromState()
    slideinModule.slideinForContentElement(aliaspageContent)
    return

#endregion

module.exports = aliaspagemodule