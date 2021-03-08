secretstoremodule = {name: "secretstoremodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["secretstoremodule"]?  then console.log "[secretstoremodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
state = null

############################################################
clientsList = []
idToObjMap = {}

############################################################
secretstoremodule.initialize = ->
    log "secretstoremodule.initialize"
    state = allModules.statemodule
    state.set("clientsList", clientsList)
    return

############################################################
removeClientFromList = (client) ->
    return if clientsList.length == 0

    lastIndex = clientsList.length - 1
    lastObj = clientsList[lastIndex]

    for obj,i in clientsList when client == obj.client
        if client != lastObj then clientsList[i] = lastObj

    clientsList.length -= 1
    return

############################################################
secretstoremodule.storeNewClient = (client, type) ->
    log "secretstoremodule.storeNewClient"
    try id = client.publicKeyHex
    catch err then return
    return if idToObjMap[id]?
    
    obj = {client, type}
    idToObjMap[id] = obj

    clientsList.push(obj)
    state.callOutChange("clientsList")
    return

secretstoremodule.removeClient = (client) ->
    log "secretstoremodule.removeClient"
    try id = client.publicKeyHex
    catch err then return
    return unless idToObjMap[id]?
    
    delete idToObjMap[id]
    
    removeClientFromList(client)
    state.callOutChange("clientsList")
    return

secretstoremodule.clientByIndex = (index) ->
    log "secretstoremodule.clientByIndex"
    return clientsList[index]

module.exports = secretstoremodule