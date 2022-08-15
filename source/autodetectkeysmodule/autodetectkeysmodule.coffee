############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("autodetectkeysmodule")
#endregion


############################################################
#region localModules
import * as clientFactory from "secret-manager-client"

############################################################
import * as utl from "./utilsmodule.js"
import * as state from "./statemodule.js"
import * as aliasModule from "./idaliasmodule.js"
import * as clientStore from "./clientstoremodule.js"

baseClient = null
#endregion

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
export detectFor  = (client) ->
    log "detectFor"
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
