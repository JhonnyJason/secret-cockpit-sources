secretsdisplaymodule = {name: "secretsdisplaymodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["secretsdisplaymodule"]?  then console.log "[secretsdisplaymodule]: " + arg
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
elementTemplate = "null"

############################################################
secretsdisplaymodule.initialize = ->
    log "secretsdisplaymodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    elementTemplate = hiddenClientsDisplayTemplate.innerHTML

    state.addOnChangeListener("clientsList", displayAllKnownClients)
    return
    
############################################################
displayAllKnownClients = ->
    log "displayAllKnownClients"
    clientsList = state.get("clientsList")
    
    cObj = {}
    content = ""
    for obj,i in clientsList
        cObj.index = i
        cObj.type = obj.type
        cObj.id = utl.add0x(obj.client.publicKeyHex)        
        content += mustache.render(elementTemplate, cObj)

    if content then clientsDisplayContainer.innerHTML = content
    return

module.exports = secretsdisplaymodule