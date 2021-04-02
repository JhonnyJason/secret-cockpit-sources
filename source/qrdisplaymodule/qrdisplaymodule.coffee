qrdisplaymodule = {name: "qrdisplaymodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["qrdisplaymodule"]?  then console.log "[qrdisplaymodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
QR = require("vanillaqr").default

############################################################
currentQr = null

############################################################
qrdisplaymodule.initialize = ->
    log "qrdisplaymodule.initialize"

    options = 
        url: ""
        size: 320
        toTable: false
        ecclevel: 3
        noBorder: false
        borderSize: 4

    currentQr = new QR(options)
    qrdisplayBackground.appendChild(currentQr.domElement)    

    qrdisplayBackground.addEventListener("click", qrClicked)

    return

############################################################
qrClicked = ->
    log "qrClicked"
    qrdisplayBackground.classList.remove("active")
    return

############################################################
qrdisplaymodule.displayCode = (information) ->
    log "qrdisplaymodule.displayCode"
    log information
    currentQr.url = information
    currentQr.init()
    qrdisplayBackground.classList.add("active")
    return

module.exports = qrdisplaymodule