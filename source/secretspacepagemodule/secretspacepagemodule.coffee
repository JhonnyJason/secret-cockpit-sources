secretspacepagemodule = {name: "secretspacepagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["secretspacepagemodule"]?  then console.log "[secretspacepagemodule]: " + arg
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
secretStore = null
slideinModule = null

#endregion

clientObject = null

############################################################
secretspacepagemodule.initialize = ->
    log "secretspacepagemodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    secretStore = allModules.secretstoremodule
    slideinModule = allModules.slideinframemodule
    # secretspacepageContent.
    slideinModule.wireUp(secretspacepageContent, clearContent, applyContent)

    return

############################################################
#region internalFunctions
displayClientInformation = ->
    log "displayClientInformation"
    idLine.textContent = utl.add0x(clientObject.client.publicKeyHex)
    secretLine.textContent = utl.add0x(clientObject.client.secretKeyHex)
    typeLine.textContent = clientObject.type
    return

displayCurrentSecretSpace = ->
    log "displayCurrentSecretSpace"
    space = await clientObject.client.getSecretSpace()
    olog space
    return

############################################################
clearContent = ->
    log "clearContent"
    clientObject = null
    state.set("chosenClientIndex", null)
    secretsContainer.innerHTML = ""
    return

applyContent = ->
    log "applyContent"
    ## TODO?
    clearContent()
    return

#endregion

############################################################
#region exposedFunctions
secretspacepagemodule.slideOut = ->
    log "secretspacepagemodule.slideOut"
    slideinModule.slideoutForContentElement(secretspacepageContent)
    return

secretspacepagemodule.slideIn = ->
    log "secretspacepagemodule.slideIn"
    idx = state.get("chosenClientIndex")
    if typeof idx != "number" then throw new Error("chosenClientIndex was not a number!")
    clientObject = secretStore.clientByIndex(idx)
    slideinModule.slideinForContentElement(secretspacepageContent)
    displayClientInformation()
    displayCurrentSecretSpace()
    return

#endregion

    
module.exports = secretspacepagemodule

# 0x1753ee5973aab738cf12ca504dc29cf8d13376591264417b69752f02c7467d3c
# id: 0x5a23be423d7d7bd62b6217823c9399f2a15771bbc84f3e871b5bbbe7a9d56478
# 0xadc352777ebdf7351f8dcc129c8c97ff4507fe5af451d9ff8adc428432d12ba0
# id: 0x4c597f1d71fef4695d17976f780ca4175ab71037a9136672ba779f47490a452d