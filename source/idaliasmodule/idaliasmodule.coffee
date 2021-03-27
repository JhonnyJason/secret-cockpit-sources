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

    (idToAlias[id] = alias) for alias,id of aliasToId
    olog aliasToId
    olog idToAlias
    return

############################################################
#region exposedFunctions
idaliasmodule.idFrom = (alias) -> aliasToId[alias]

idaliasmodule.aliasFrom = (id) -> idToAlias[id]

idaliasmodule.getAllIds = -> Object.keys(idToAlias)

idaliasmodule.updateAlias = (alias, id) ->
    oldAlias = idToAlias[id] 
    if oldAlias? and oldAlias != alias then delete idToAlias[id]

    if !alias then delete aliasToId[oldAlias]
    else
        aliasToId[alias] = id
        idToAlias[id] = alias

    state.save("aliasToId")
    state.callOutChange("aliasToId")
    return

idaliasmodule.applyAliases = (idAliasList) ->
    log "idaliasmodule.applyAliases"
    for pair in idAliasList
        oldAlias = idToAlias[pair.id] 
        delete idToAlias[pair.id]

        if !pair.alias then delete aliasToId[oldAlias]
        else
            aliasToId[pair.alias] = pair.id
            idToAlias[pair.id] = pair.alias
    
    state.save("aliasToId")
    state.callOutChange("aliasToId")
    return

#endregion
    
module.exports = idaliasmodule