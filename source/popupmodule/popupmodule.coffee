############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("popupmodule")
#endregion

############################################################
#region internalFunctions

############################################################
popup = (frame) ->
    log "popup"
    frame.classList.add("active")
    return

disappear = (frame) ->
    log "disappear"
    frame.classList.remove("active")
    return

############################################################
#region elementsRetrieval
getPopupFrameForContentElement = (contentElement) ->
    log "getPopupFrameForContentElement"
    frame = contentElement.parentElement.parentElement
    return frame

getAcceptButtonForContentElement = (contentElement) ->
    log "getGoButtonForContentElement"
    frame = contentElement.parentElement.parentElement
    return frame.getElementsByClassName("popup-accept-button")[0]

getClickCatcherForContentElement = (contentElement) ->
    log "getClickCatcherForContentElement"
    frame = contentElement.parentElement.parentElement
    return frame.getElementsByClassName("click-catcher")[0]

getCancelButtonForContentElement = (contentElement) ->
    log "getCloseButtonForContentElement"
    frame = contentElement.parentElement.parentElement
    return frame.getElementsByClassName("popup-cancel-button")[0]

#endregion

#endregion

############################################################
export popupForContentElement = (contentElement) ->
    log "popupmodule.popupForContentElement"
    frame = getPopupFrameForContentElement(contentElement)
    popup(frame)
    return

export wireUp = (contentElement, applyFunction) ->
    log "popupmodule.popupForContentElement"
    frame = getPopupFrameForContentElement(contentElement)
    acceptButton = getAcceptButtonForContentElement(contentElement)
    clickCatcher = getClickCatcherForContentElement(contentElement)
    cancelButton = getCancelButtonForContentElement(contentElement)

    cancelFunction = ->
        disappear(frame)
        return
    acceptFunction = ->
        applyFunction()
        disappear(frame)
        return

    acceptButton.addEventListener("click", acceptFunction)
    cancelButton.addEventListener("click", cancelFunction)
    clickCatcher.addEventListener("click", cancelFunction)
    return

