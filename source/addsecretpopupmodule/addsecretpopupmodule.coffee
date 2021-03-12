addsecretpopupmodule = {name: "addsecretpopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["addsecretpopupmodule"]?  then console.log "[addsecretpopupmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
popupModule = null
secretSpacePage = null

############################################################
currentClient = null

############################################################
addsecretpopupmodule.initialize = ->
    log "addsecretpopupmodule.initialize"
    popupModule = allModules.popupmodule
    secretSpacePage = allModules.secretspacepagemodule

    #addsecretPopup.
    popupModule.wireUp(addsecretPopup, applyAdd)
    return

############################################################
applyAdd = ->
    log "applyAdd"
    label = addLabelLine.textContent
    if !label then return
    secret = addSecretLine.textContent

    await currentClient.setSecret(label, secret)
    secretSpacePage.slideIn()
    return

############################################################
addsecretpopupmodule.addSecret = (client) ->
    log "addsecretpopupmodule.addSecret"
    currentClient = client

    editLabelLine.textContent = ""
    editSecretLine.textContent = ""
    popupModule.popupForContentElement(addsecretPopup)
    return

    
module.exports = addsecretpopupmodule