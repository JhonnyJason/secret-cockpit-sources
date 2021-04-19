clientsdisplaymodule = {name: "clientsdisplaymodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["clientsdisplaymodule"]?  then console.log "[clientsdisplaymodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
mustache = require("mustache")

############################################################
state = null
utl = null

############################################################
template = null
emptyContainerElement ="<p>No Known Account here :-)</p>"

############################################################
clientsdisplaymodule.initialize = ->
    log "clientsdisplaymodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    template = hiddenClientsDisplayTemplate.innerHTML

    displayAllKnownClients()
    state.addOnChangeListener("aliasToId", displayAllKnownClients)
    state.addOnChangeListener("clientsList", displayAllKnownClients)
    aliasPageButton.addEventListener("click", aliasPageButtonClicked)
    return
    
############################################################
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


module.exports = clientsdisplaymodule