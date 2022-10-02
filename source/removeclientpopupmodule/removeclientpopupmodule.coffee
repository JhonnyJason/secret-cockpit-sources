removeclientpopupmodule = {name: "removeclientpopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["removeclientpopupmodule"]?  then console.log "[removeclientpopupmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region localModules
utl = null
popupModule = null
clientStore = null
secretSpacePage = null

#endregion

############################################################
currentClient = null

############################################################
removeclientpopupmodule.initialize = ->
    log "removeclientpopupmodule.initialize"
    utl = allModules.utilsmodule
    popupModule = allModules.popupmodule
    clientStore = allModules.clientstoremodule
    secretSpacePage = allModules.secretspacepagemodule

    #removeclientPopup.
    popupModule.wireUp(removeclientPopup, applyRemoval)
    return

############################################################
applyRemoval = ->
    log "applyRemoval"
    clientStore.removeClient(currentClient)
    secretSpacePage.slideOut()
    return

############################################################
removeclientpopupmodule.removeClient = (client) ->
    log "removeclientpopupmodule.removeclient"
    currentClient = client

    clientToRemoveId.textContent = utl.add0x(client.publicKeyHex)

    popupModule.popupForContentElement(removeclientPopup)
    return

    
module.exports = removeclientpopupmodule