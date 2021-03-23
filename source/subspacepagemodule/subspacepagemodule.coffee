subspacepagemodule = {name: "subspacepagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["subspacepagemodule"]?  then console.log "[subspacepagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region localModules
clientFactory  = require("secret-manager-client")
mustache = require("mustache")

############################################################
utl = null
state = null
secretStore = null
slideinModule = null

############################################################
editPopup = null
addPopup = null
deletePopup = null

#endregion

############################################################
#region internal Properties
clientObject = null
currentSubspace = null

############################################################
secretTemplate = null

noSecretElement = "<p>No Secret in this Subspace :-)</p>"
#endregion

############################################################
subspacepagemodule.initialize = ->
    log "subspacepagemodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    secretStore = allModules.clientstoremodule
    slideinModule = allModules.slideinframemodule

    editPopup = allModules.editsecretpopupmodule
    addPopup = allModules.addsecretpopupmodule
    deletePopup = allModules.deletesecretpopupmodule

    secretTemplate = hiddenSecretTemplate.innerHTML

    # subspacepageContent.
    slideinModule.wireUp(subspacepageContent, clearContent, applyContent)
    

    copySharedFromIdButton.addEventListener("click", copySharedFromIdButtonClicked)
    qrForSharedFromIdButton.addEventListener("click", qrForSharedFromIdButtonClicked)

    copySharedToIdButton.addEventListener("click", copySharedToIdButtonClicked)
    qrForSharedToIdButton.addEventListener("click", qrForSharedToIdButtonClicked)
    return

############################################################
#region internalFunctions
getSecretId = (el) ->
    return el.parentElement.parentElement.getAttribute("secret-id")

############################################################
#region secretsEvents
# deleteSecretButtonClicked = (evt) ->
#     log "deleteSecretButtonClicked"
#     secretId = getSecretId(evt.target)
#     deletePopup.deleteSecret(clientObject.client, secretId)
#     return

# editSecretButtonClicked = (evt) ->
#     log "editSecretButtonClicked"
#     secretId = getSecretId(evt.target)
#     editPopup.editSecret(clientObject.client, secretId)
#     return


copySecretButtonClicked = (evt) ->
    log "copySecretButtonClicked"
    setterId = state.get("chosenSubspaceId")
    secretId = getSecretId(evt.target)
    secret = await clientObject.client.getSecretFrom(secretId, setterId)
    utl.copyToClipboard(secret)
    return

storeSecretButtonClicked = (evt) ->
    log "storeSecretButtonClicked"
    #TODO
    return

shareSecretButtonClicked = (evt) ->
    log "shareSecretButtonClicked"
    #TODO
    return

#endregion


############################################################
#region detailSectionEvents
copySharedFromIdButtonClicked = ->
    log "copySharedFromIdButtonClicked"
    id = state.get("chosenSubspaceId")
    utl.copyToClipboard(id)
    return

qrForSharedFromIdButtonClicked = ->
    log "qrForSharedFromIdButtonClicked"
    ##TODO
    return

############################################################
copySharedToIdButtonClicked = ->
    log "copySharedToIdButtonClicked"
    id = clientObject.client.publicKeyHex
    utl.copyToClipboard(id)
    return

qrForSharedToIdButtonClicked = ->
    log "qrForSharedToIdButtonClicked"
    ##TODO
    return

#endregion


############################################################
#region displayFunctions
displayDetailsInformation = ->
    log "displayDetailsInformation"
    sharedToIdLine.textContent = utl.add0x(clientObject.client.publicKeyHex)
    sharedFromId = state.get("chosenSubspaceId")
    sharedFromIdLine.textContent = utl.add0x(sharedFromId)
    return

displayCurrentSubspace = ->
    log "displayCurrentSubspace"
    secretIds = Object.keys(currentSubspace)

    cObj = {}
    content = ""
    for id in secretIds
        cObj.secretId = id
        content += mustache.render(secretTemplate, cObj)

    if content then sharedSecretsContainer.innerHTML = content
    else sharedSecretsContainer.innerHTML = noSecretElement
    
    copyButtons = sharedSecretsContainer.getElementsByClassName("copy-secret-button")
    btn.addEventListener("click", copySecretButtonClicked) for btn in copyButtons
    
    storeButtons = sharedSecretsContainer.getElementsByClassName("store-secret-button")
    btn.addEventListener("click", storeSecretButtonClicked) for btn in storeButtons

    shareButtons = sharedSecretsContainer.getElementsByClassName("share-secret-button")
    btn.addEventListener("click", shareSecretButtonClicked) for btn in shareButtons
    return


#endregion

############################################################
clearContent = ->
    log "clearContent"
    clientObject = null
    state.set("chosenSubspaceId", null)
    sharedSecretsContainer.innerHTML = ""
    return

applyContent = ->
    log "applyContent"
    ## TODO?
    clearContent()
    return

#endregion

############################################################
#region exposedFunctions
subspacepagemodule.slideOut = ->
    log "subspacepagemodule.slideOut"
    slideinModule.slideoutForContentElement(subspacepageContent)
    return

subspacepagemodule.slideIn = ->
    log "subspacepagemodule.slideIn"
    idx = state.get("chosenClientIndex")
    if typeof idx != "number" then throw new Error("chosenClientIndex was not a number!")
    clientObject = secretStore.clientByIndex(idx)
    slideinModule.slideinForContentElement(subspacepageContent)
    space = await clientObject.client.getSecretSpace()
    fromId = state.get("chosenSubspaceId")
    currentSubspace = space[fromId]

    olog currentSubspace

    displayDetailsInformation()
    displayCurrentSubspace()
    return

#endregion

    
module.exports = subspacepagemodule

# 0xe1400aa698ca52b67510a0b7a22daef4bac99807b511cd2508689064154b5c29
# id: 0x43b9a9eea29d7fe5efaba10b45651afb41f3fee540cd4ed18ef5b5311483c4ca

# 0x1753ee5973aab738cf12ca504dc29cf8d13376591264417b69752f02c7467d3c
# id: 0x5a23be423d7d7bd62b6217823c9399f2a15771bbc84f3e871b5bbbe7a9d56478
# 0xadc352777ebdf7351f8dcc129c8c97ff4507fe5af451d9ff8adc428432d12ba0
# id: 0x4c597f1d71fef4695d17976f780ca4175ab71037a9136672ba779f47490a452d
