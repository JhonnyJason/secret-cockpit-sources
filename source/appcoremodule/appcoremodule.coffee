############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("appcoremodule")
#endregion

############################################################
import * as clientFactory from "secret-manager-client"

############################################################
import *  as state from "./statemodule.js"
import *  as clientStore from "./clientstoremodule.js"


############################################################
export startUp = ->
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
    
