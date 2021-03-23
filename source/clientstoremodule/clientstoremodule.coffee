clientstoremodule = {name: "clientstoremodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["clientstoremodule"]?  then console.log "[clientstoremodule]: " + arg
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
clientstoremodule.initialize = ->
    log "clientstoremodule.initialize"
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
clientstoremodule.storeNewClient = (client, type) ->
    log "clientstoremodule.storeNewClient"
    try id = client.publicKeyHex
    catch err then return
    return if idToObjMap[id]?
    
    obj = {client, type}
    idToObjMap[id] = obj

    clientsList.push(obj)
    state.callOutChange("clientsList")
    return

clientstoremodule.removeClient = (client) ->
    log "clientstoremodule.removeClient"
    try id = client.publicKeyHex
    catch err then return
    return unless idToObjMap[id]?
    
    delete idToObjMap[id]
    
    removeClientFromList(client)
    state.callOutChange("clientsList")
    return

clientstoremodule.clientByIndex = (index) ->
    log "clientstoremodule.clientByIndex"
    return clientsList[index]

clientstoremodule
module.exports = clientstoremodule