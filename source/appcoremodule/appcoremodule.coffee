appcoremodule = {name: "appcoremodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["appcoremodule"]?  then console.log "[appcoremodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
clientFactory  = require("secret-manager-client")

############################################################
state = null
clientStore = null

############################################################
appcoremodule.initialize = ->
    log "appcoremodule.initialize"
    state = allModules.statemodule
    clientStore = allModules.clientstoremodule
    return

############################################################
appcoremodule.startUp = ->
    log "appcoremodule.startUp"
    # allModules.aliaspagemodule.slideIn()
    return
    allModules.settingspagemodule.slideIn()
    return

    url = state.get("secretManagerURL")
    mockedKey = "e1400aa698ca52b67510a0b7a22daef4bac99807b511cd2508689064154b5c29"
    client = await clientFactory.createClient(mockedKey, null, url)

    clientStore.storeNewClient(client, "unsafe")

    state.set("chosenClientIndex", 0)
    allModules.secretspacepagemodule.slideIn()
    return
    

module.exports = appcoremodule