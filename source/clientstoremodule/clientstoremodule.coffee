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
clientFactory  = require("secret-manager-client")

############################################################
state = null

############################################################
clientsList = []
idToObjMap = {}

storeUnsafeInLocalStorage = false
storedUnsafe = []

############################################################
clientstoremodule.initialize = ->
    log "clientstoremodule.initialize"
    state = allModules.statemodule
    state.set("clientsList", clientsList)
    storedUnsafe = state.load("storedUnsafe")
    if !storedUnsafe?
        storedUnsafe = []
        state.save("storedUnsafe", storedUnsafe)

    storeUnsafeInLocalStorage = state.get("storeUnsafeInLocalStorage")
    state.addOnChangeListener("storeUnsafeInLocalStorage", storingSettingChanged)
    storingSettingChanged()

    url = state.get("secretManagerURL")
    try
        promises = (clientFactory.createClient(unsafe,null,url) for unsafe in storedUnsafe)
        clients = await Promise.all(promises)
        clientstoremodule.storeNewClient(client, "unsafe") for client in clients
    catch err then log err
    return

############################################################
#region internalFunctions
removeClientFromList = (client) ->
    return if clientsList.length == 0

    lastIndex = clientsList.length - 1
    lastObj = clientsList[lastIndex]

    for obj,i in clientsList when client == obj.client
        if client != lastObj then clientsList[i] = lastObj

    clientsList.length -= 1
    return


############################################################
#region localStorageFunction
storingSettingChanged = ->
    storeUnsafeInLocalStorage = state.get("storeUnsafeInLocalStorage")
    if storeUnsafeInLocalStorage
        for id,obj of idToObjMap when obj.type == "unsafe"
            storeUnsafe(obj.client.secretKeyHex)
    else
        storedUnsafe.length = 0
        state.save("storedUnsafe")
    return

storeUnsafe = (key) ->
    return unless storeUnsafeInLocalStorage
    for unsafe in storedUnsafe when unsafe == key then return
    storedUnsafe.push(key)
    state.save("storedUnsafe")
    return

removeUnsafeFromStorage = (key) ->
    return unless storeUnsafeInLocalStorage
    length = storedUnsafe.length
    return unless length > 0
    lastKey = storedUnsafe[length - 1]
    for unsafe,i in storedUnsafe when unsafe == key
        storedUnsafe[i] = lastKey
        storedUnsafe.length = length - 1
        state.save("storedUnsafe")
    return

#endregion

#endregion

############################################################
#region exposedFunctions
clientstoremodule.storeNewClient = (client, type) ->
    log "clientstoremodule.storeNewClient"
    try id = client.publicKeyHex
    catch err then return
    return if idToObjMap[id]?
    
    obj = {client, type}
    idToObjMap[id] = obj

    ## For localStorage
    if type == "unsafe" then storeUnsafe(client.secretKeyHex)

    clientsList.push(obj)
    state.callOutChange("clientsList")
    return

clientstoremodule.removeClient = (client) ->
    log "clientstoremodule.removeClient"
    try id = client.publicKeyHex
    catch err then return
    return unless idToObjMap[id]?
    
    ## For localStorage
    if idToObjMap[id].type == "unsafe" then removeUnsafeFromStorage(client.secretKeyHex)

    delete idToObjMap[id]
    
    removeClientFromList(client)
    state.callOutChange("clientsList")
    return

clientstoremodule.clientByIndex = (index) ->
    log "clientstoremodule.clientByIndex"
    return clientsList[index]

clientstoremodule.clientById = (id) ->
    log "clientstoremodule.clientById"
    return idToObjMap[id]
    
#endregion

module.exports = clientstoremodule