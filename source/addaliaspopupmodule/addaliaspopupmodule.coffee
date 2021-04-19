addaliaspopupmodule = {name: "addaliaspopupmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["addaliaspopupmodule"]?  then console.log "[addaliaspopupmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
utl = null
aliasModule = null
popupModule = null
aliasPage = null

############################################################
addaliaspopupmodule.initialize = ->
    log "addaliaspopupmodule.initialize"
    utl = allModules.utilmodule
    aliasModule = allModules.idaliasmodule
    popupModule = allModules.popupmodule
    aliasPage = allModules.aliaspagemodule

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
addaliaspopupmodule.addAlias = ->
    log "addaliaspopupmodule.addSecret"
    addAliasIdLine.textContent = ""
    addAliasLine.textContent = ""
    popupModule.popupForContentElement(addaliasPopup)
    return

    
module.exports = addaliaspopupmodule