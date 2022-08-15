############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("addaliaspopupmodule")
#endregion

############################################################
#region imports
import * as utl from "./utilsmodule.js"
import * as aliasModule from "./idaliasmodule.js"
import * as popupModule from "./popupmodule.js"
import * as aliasPage from "./aliaspagemodule.js"

#endregion

############################################################
export initialize = ->
    log "initialize"

    #addaliasPopup.
    popupModule.wireUp(addaliasPopup, applyAdd)
    return

############################################################
applyAdd = ->
    log "applyAdd"

    id = addAliasIdLine.textContent
    alias = addAliasLine.textContent
    return unless alias? and alias.length and id? and id.length
    
    id = utl.strip0x(id)

    aliasModule.updateAlias(alias, id)
    aliasPage.slideIn()
    return

############################################################
export addAlias = ->
    log "addaliaspopupmodule.addSecret"
    addAliasIdLine.textContent = ""
    addAliasLine.textContent = ""
    popupModule.popupForContentElement(addaliasPopup)
    return

    
