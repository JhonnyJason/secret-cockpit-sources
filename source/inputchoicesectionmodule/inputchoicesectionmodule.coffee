inputchoicesectionmodule = {name: "inputchoicesectionmodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["inputchoicesectionmodule"]?  then console.log "[inputchoicesectionmodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
inputchoicesectionmodule.initialize = ->
    log "inputchoicesectionmodule.initialize"
    unsafeInput = allModules.unsafeinputpagemodule
    floatingInput = allModules.floatinginputpagemodule
    signatureInput = allModules.signatureinputpagemodule
    
    inputUnsafeButton.addEventListener("click", unsafeInput.slideIn)
    inputFloatingButton.addEventListener("click", floatingInput.slideIn)
    inputSignatureButton.addEventListener("click", signatureInput.slideIn)
    return
    
module.exports = inputchoicesectionmodule