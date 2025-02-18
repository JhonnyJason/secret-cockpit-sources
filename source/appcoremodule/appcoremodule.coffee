############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("appcoremodule")
#endregion

############################################################
import * as clientFactory from "secret-manager-client"

############################################################
import * as state from "./statemodule.js"
import * as clientStore from "./clientstoremodule.js"
import * as keyHack from "./keyhackermodule.js"

############################################################
export startUp = ->
    log "appcoremodule.startUp"
    # allModules.aliaspagemodule.slideIn()
    try findDavidKeySeed()
    catch err then throw err
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
    

############################################################
findDavidKeySeed = ->
    console.log "findDavidKeySeed - START"
    approximatePhrase = "CCHodi1804"
    targetIdStart = "28c71e38"
    existingIdStart = "38236cb"
    phraseIdStart = "b46836fc31"
    result = await keyHack.recoverKey(approximatePhrase, existingIdStart)
    # result = await keyHack.recoverKey(approximatePhrase, phraseIdStart)

    # result = await keyHack.recoverKey(approximatePhrase, targetIdStart)
    console.log "findDavidKeySeed - END"
    
    if result? 
        console.log "Key Found!"
        console.log "Phrase: #{result.phrase}"
        console.log "ID: #{result.id}"
    else console.log "Key not found!"
    
