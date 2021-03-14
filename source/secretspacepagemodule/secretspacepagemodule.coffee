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
editPopup = null
addPopup = null
deletePopup = null

#endregion

############################################################
#region internal Properties
clientObject = null

############################################################
template = null
emptyContainerElement = "<p>No Secrets in this Space :-)</p>"

#endregion

############################################################
secretspacepagemodule.initialize = ->
    log "secretspacepagemodule.initialize"
    utl = allModules.utilmodule
    state = allModules.statemodule
    secretStore = allModules.secretstoremodule
    slideinModule = allModules.slideinframemodule

    editPopup = allModules.editsecretpopupmodule
    addPopup = allModules.addsecretpopupmodule
    deletePopup = allModules.deletesecretpopupmodule

    template = hiddenSecretTemplate.innerHTML

    # secretspacepageContent.
    slideinModule.wireUp(secretspacepageContent, clearContent, applyContent)
    
    addSecretButton.addEventListener("click", addSecretButtonClicked)
    return

############################################################
#region internalFunctions
addSecretButtonClicked = ->
    log "addSecretButtonClicked"
    addPopup.addSecret(clientObject.client)
    return

editSecretButtonClicked = (evt) ->
    log "editSecretButtonClicked"
    secretId = getSecretId(evt.target)
    editPopup.editSecret(clientObject.client, secretId)
    return

deleteSecretButtonClicked = (evt) ->
    log "deleteSecretButtonClicked"
    secretId = getSecretId(evt.target)
    deletePopup.deleteSecret(clientObject.client, secretId)
    return

getSecretId = (el) ->
    return el.parentElement.parentElement.getAttribute("secret-id")

############################################################
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
    space = await clientObject.client.getSecretSpace()
    # olog space
    secretIds = Object.keys(space)

    cObj = {}
    content = ""
    for id in secretIds when space[id].secret?
        cObj.secretId = id
        content += mustache.render(template, cObj)

    if content then secretsContainer.innerHTML = content
    else secretsContainer.innerHTML = emptyContainerElement

    editButtons = secretsContainer.getElementsByClassName("edit-secret-button")
    btn.addEventListener("click", editSecretButtonClicked) for btn in editButtons
    deleteButtons = secretsContainer.getElementsByClassName("delete-secret-button")
    btn.addEventListener("click", deleteSecretButtonClicked) for btn in deleteButtons

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

# 0xe1400aa698ca52b67510a0b7a22daef4bac99807b511cd2508689064154b5c29
# id: 0x43b9a9eea29d7fe5efaba10b45651afb41f3fee540cd4ed18ef5b5311483c4ca

# 0x1753ee5973aab738cf12ca504dc29cf8d13376591264417b69752f02c7467d3c
# id: 0x5a23be423d7d7bd62b6217823c9399f2a15771bbc84f3e871b5bbbe7a9d56478
# 0xadc352777ebdf7351f8dcc129c8c97ff4507fe5af451d9ff8adc428432d12ba0
# id: 0x4c597f1d71fef4695d17976f780ca4175ab71037a9136672ba779f47490a452d
