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
mustache = require("mustache")

############################################################
utl = null
state = null
secretStore = null
slideinModule = null

############################################################
subspacePage = null

############################################################
editPopup = null
addPopup = null
deletePopup = null
addSubspacePopup = null
deleteSubspacePopup = null
#endregion

############################################################
#region internal Properties
clientObject = null
currentSpace = null

############################################################
secretTemplate = null
subspaceTemplate = null

noSecretElement = "<p>No Secret in this Space :-)</p>"
noSubspaceElement = "<p>No Subspace yet :-)</p>"
#endregion

############################################################
secretspacepagemodule.initialize = ->
    log "secretspacepagemodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    secretStore = allModules.secretstoremodule
    slideinModule = allModules.slideinframemodule

    subspacePage = allModules.subspacepagemodule

    editPopup = allModules.editsecretpopupmodule
    addPopup = allModules.addsecretpopupmodule
    deletePopup = allModules.deletesecretpopupmodule
    addSubspacePopup = allModules.addsubspacepopupmodule
    deleteSubspacePopup = allModules.deletesubspacepopupmodule

    secretTemplate = hiddenSecretTemplate.innerHTML
    subspaceTemplate = hiddenSubspaceTemplate.innerHTML

    # secretspacepageContent.
    slideinModule.wireUp(secretspacepageContent, clearContent, applyContent)
    
    addSecretButton.addEventListener("click", addSecretButtonClicked)
    shareNewSecretButton.addEventListener("click", shareNewSecretButtonClicked)
    
    addSubspaceButton.addEventListener("click", addSubspaceButtonClicked)

    copyIdButton.addEventListener("click", copyIdButtonClicked)
    qrForIdButton.addEventListener("click", qrForIdButtonClicked)
    copySecretKeyButton.addEventListener("click", copySecretKeyButtonClicked)
    qrForSecretKeyButton.addEventListener("click", qrForSecretKeyButtonClicked)
    storeSecretKeyButton.addEventListener("click", storeSecretKeyButtonClicked)
    return

############################################################
#region internalFunctions
getSecretId = (el) ->
    return el.parentElement.parentElement.getAttribute("secret-id")

getSubspaceId = (el) ->
    return el.parentElement.getAttribute("subspace-id")

############################################################
#region directSecretsEvents
deleteSecretButtonClicked = (evt) ->
    log "deleteSecretButtonClicked"
    secretId = getSecretId(evt.target)
    deletePopup.deleteSecret(clientObject.client, secretId)
    return

editSecretButtonClicked = (evt) ->
    log "editSecretButtonClicked"
    secretId = getSecretId(evt.target)
    editPopup.editSecret(clientObject.client, secretId)
    return


copySecretButtonClicked = (evt) ->
    log "copySecretButtonClicked"
    secretId = getSecretId(evt.target)
    secret = await clientObject.client.getSecret(secretId)
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

addSecretButtonClicked = ->
    log "addSecretButtonClicked"
    addPopup.addSecret(clientObject.client)
    return

shareNewSecretButtonClicked = ->
    log "shareNewSecretButtonClicked"
    #TODO
    return

#endregion

############################################################
#region subspacesEvents
subspaceClicked = (evt) ->
    log "subspaceClicked"
    id = getSubspaceId(evt.target)
    state.set("chosenSubspaceId", id)
    subspacePage.slideIn()
    return

deleteSubspaceButtonClicked = (evt) ->
    log "deleteSubspaceButtonClicked"
    id = getSubspaceId(evt.target)
    deleteSubspacePopup.deleteSubspace(clientObject.client, id)
    return

addSubspaceButtonClicked = ->
    log "addSubspaceButtonClicked"
    addSubspacePopup.addSubspace(clientObject.client)
    return

#endregion

############################################################
#region detailSectionEvents
copyIdButtonClicked = ->
    log "copyIdButtonClicked"
    utl.copyToClipboard(clientObject.client.publicKeyHex)
    return

qrForIdButtonClicked = ->
    log "qrForIdButtonClicked"
    ##TODO
    return

copySecretKeyButtonClicked = ->
    log "copySecretKeyButtonClicked"
    utl.copyToClipboard(clientObject.client.secretKeyHex)
    return

qrForSecretKeyButtonClicked = ->
    log "qrForSecretKeyButtonClicked"
    ##TODO
    return

storeSecretKeyButtonClicked = ->
    log "storeSecretKeyButtonClicked"
    ##TODO
    return

#endregion

############################################################
#region displayFunctions
displayClientInformation = ->
    log "displayClientInformation"
    idLine.textContent = utl.add0x(clientObject.client.publicKeyHex)
    secretKeyHandleLine.className = clientObject.type
    if clientObject.type == "unsafe" 
        secretKeyLine.textContent = utl.add0x(clientObject.client.secretKeyHex)
    else secretKeyLine.textContent = ""
    return

displayCurrentSecretSpace = ->
    log "displayCurrentSecretSpace"
    secretIds = Object.keys(currentSpace)

    cObj = {}
    content = ""
    for id in secretIds when currentSpace[id].secret?
        cObj.secretId = id
        content += mustache.render(secretTemplate, cObj)

    if content then secretsContainer.innerHTML = content
    else secretsContainer.innerHTML = noSecretElement

    editButtons = secretsContainer.getElementsByClassName("edit-secret-button")
    btn.addEventListener("click", editSecretButtonClicked) for btn in editButtons

    deleteButtons = secretsContainer.getElementsByClassName("delete-secret-button")
    btn.addEventListener("click", deleteSecretButtonClicked) for btn in deleteButtons
    
    copyButtons = secretsContainer.getElementsByClassName("copy-secret-button")
    btn.addEventListener("click", copySecretButtonClicked) for btn in copyButtons
    
    storeButtons = secretsContainer.getElementsByClassName("store-secret-button")
    btn.addEventListener("click", storeSecretButtonClicked) for btn in storeButtons

    shareButtons = secretsContainer.getElementsByClassName("share-secret-button")
    btn.addEventListener("click", shareSecretButtonClicked) for btn in shareButtons
    return

displaySubspaces = ->
    log "displaySubspaces"
    secretIds = Object.keys(currentSpace)

    cObj = {}
    content = ""
    for id in secretIds when !currentSpace[id].secret?
        cObj.subspaceId = id
        content += mustache.render(subspaceTemplate, cObj)

    if content then subspacesContainer.innerHTML = content
    else subspacesContainer.innerHTML = noSubspaceElement

    subspaceButtons = subspacesContainer.getElementsByClassName("subspace-id")
    btn.addEventListener("click", subspaceClicked) for btn in subspaceButtons
    
    deleteButtons = subspacesContainer.getElementsByClassName("delete-subspace-button")
    btn.addEventListener("click", deleteSubspaceButtonClicked) for btn in deleteButtons
    return

#endregion

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
    currentSpace = await clientObject.client.getSecretSpace()
    # olog currentSpace
    displayClientInformation()
    displayCurrentSecretSpace()
    displaySubspaces()
    return

#endregion

    
module.exports = secretspacepagemodule

# 0xe1400aa698ca52b67510a0b7a22daef4bac99807b511cd2508689064154b5c29
# id: 0x43b9a9eea29d7fe5efaba10b45651afb41f3fee540cd4ed18ef5b5311483c4ca

# id: 0xd315400ace9a927eb228f5b8e18cfb2127e01109f6c89985f0016638fc6f9f3e


# 0x1753ee5973aab738cf12ca504dc29cf8d13376591264417b69752f02c7467d3c
# id: 0x5a23be423d7d7bd62b6217823c9399f2a15771bbc84f3e871b5bbbe7a9d56478
# 0xadc352777ebdf7351f8dcc129c8c97ff4507fe5af451d9ff8adc428432d12ba0
# id: 0x4c597f1d71fef4695d17976f780ca4175ab71037a9136672ba779f47490a452d
