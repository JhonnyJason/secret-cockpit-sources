
############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("addsecretpopupmodule")
#endregion

############################################################
import * as popupModule from "./popupmodule.js"
import * as secretSpacePage from "./secretspacepagemodule.js"

############################################################
currentClient = null

############################################################
export initialize = ->
    log "initialize"
    
    #addsecretPopup.
    popupModule.wireUp(addsecretPopup, applyAdd)
    return

############################################################
applyAdd = ->
    log "applyAdd"
    secretId = addSecretIdLine.textContent
    if !secretId then return
    secret = addSecretLine.textContent
    
    # log secretId
    # log secret
    # return

    await currentClient.setSecret(secretId, secret)
    secretSpacePage.slideIn()
    return

############################################################
export addSecret = (client) ->
    log "addSecret"
    currentClient = client

    addSecretIdLine.textContent = ""
    addSecretLine.textContent = ""
    popupModule.popupForContentElement(addsecretPopup)
    return
