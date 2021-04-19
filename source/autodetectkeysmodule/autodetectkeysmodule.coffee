autodetectkeysmodule = {name: "autodetectkeysmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["autodetectkeysmodule"]?  then console.log "[autodetectkeysmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion


############################################################
#region localModules
clientFactory  = require("secret-manager-client")

############################################################
utl = null
state = null
aliasModule = null
clientStore = null

baseClient = null
#endregion

############################################################
autodetectkeysmodule.initialize = ->
    log "autodetectkeysmodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    aliasModule = allModules.idaliasmodule
    clientStore = allModules.clientstoremodule

    return

############################################################
importKeyForLabel = (label) ->
    log "importKeyForLabel"
    url = state.get("secretManagerURL")
    try 
        key = await baseClient.getSecret(label)
        key = utl.strip0x(key)
        client = await clientFactory.createClient(key, null, url)
        clientStore.storeNewClient(client, "unsafe")
        
        ## Managing potential alias
        identifyingEnding = state.get("secretIdentifyingEnding")
        id = client.publicKeyHex
        alias = label.slice(0, -identifyingEnding.length)
        log alias
        if !aliasModule.aliasFrom(id)? and !aliasModule.idFrom(alias)
            aliasModule.updateAlias(alias, id)
    catch err then log err
    return

############################################################
autodetectkeysmodule.detectFor  = (client) ->
    log "autodetectkeysmodule.detectFor"
    return unless state.get("autodetectStoredSecrets")
    try
        baseClient = client
        identifyingEnding = state.get("secretIdentifyingEnding")
        space = await client.getSecretSpace()
        labels = Object.keys(space)
        log labels
        keyLabels = labels.filter((str) -> str.endsWith(identifyingEnding))
        log keyLabels
        promises = (importKeyForLabel(label) for label in keyLabels)
        await Promise.all(promises)
    catch err
        log err
    return

module.exports = autodetectkeysmodule