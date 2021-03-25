idaliasmodule = {name: "idaliasmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["idaliasmodule"]?  then console.log "[idaliasmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
state = null

############################################################
aliasToId = {}
idToAlias = {}

############################################################
idaliasmodule.initialize = ->
    log "idaliasmodule.initialize"
    state = allModules.statemodule
    
    aliasToId = state.load("aliasToId")
    
    if !aliasToId?
        aliasToId = {}
        state.save("aliasToId", aliasToId)

    idToAlias[id] = alias for alias,id in aliasToId
    return

############################################################
#region exposedFunctions
idaliasmodule.idFrom = (alias) -> aliasToId[alias]

idaliasmodule.aliasFrom = (id) -> idToAlias[id]

idaliasmodule.addAlias = (alias, id) ->
    aliasToId[alias] = id
    idToAlias[id] = alias
    state.save("aliasToId")
    return

#endregion
    
module.exports = idaliasmodule