headermodule = {name: "headermodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["headermodule"]?  then console.log "[headermodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
headermodule.initialize = ->
    log "headermodule.initialize"
    state = allModules.statemodule
    settingsPage = allModules.settingspagemodule
        
    headerRight.addEventListener("click", settingsPage.slideIn)
    return
    
module.exports = headermodule
