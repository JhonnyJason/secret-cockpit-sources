messageboxmodule = {name: "messageboxmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["messageboxmodule"]?  then console.log "[messageboxmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
stayDurationMS = 5000
currentTimeoutId = null

############################################################
messageboxmodule.initialize = ->
    log "messageboxmodule.initialize"
    c = allModules.configmodule
    if c.messageboxStayDurationMS? then stayDurationMS = c.messageboxStayDurationMS
    return

############################################################
letDisappear = ->
    log "letDisappear"
    if currentTimeoutId? then clearTimeout(currentTimeoutId)
    currentTimeoutId = setTimeout(disappear, stayDurationMS)
    return

disappear = ->
    log "disappear"
    messagebox.textContent = ""
    messagebox.className = "gone"
    currentTimeoutId = null
    return    

############################################################
messageboxmodule.info = (message) ->
    log "messageboxmodule.info"
    return unless typeof message == "string"
    messagebox.textContent = message
    messagebox.className = ""
    letDisappear()
    return

messageboxmodule.error = (message) ->
    log "messageboxmodule.error"
    return unless typeof message == "string"
    messagebox.textContent = message
    messagebox.className = "error"
    letDisappear()
    return

module.exports = messageboxmodule