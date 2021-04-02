qrreadermodule = {name: "qrreadermodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["qrreadermodule"]?  then console.log "[qrreadermodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
QRScanner = require("qr-scanner").default

############################################################
currentReader = null
hasCamera = false

############################################################
qrreadermodule.initialize = ->
    log "qrreadermodule.initialize"

    QRScanner.WORKER_PATH = "/scannerworker.js"
    hasCamera = await QRScanner.hasCamera()
    log hasCamera
    
    return unless hasCamera
    #qrreaderVideoElement.
    currentReader = new QRScanner(qrreaderVideoElement, dataRead)

    qrreaderBackground.addEventListener("click", readerClicked)
    return


############################################################
dataRead = (data) ->
    log "dataRead"
    log data
    return

readerClicked = ->
    log "readerClicked"
    currentReader.stop()

    qrreaderBackground.classList.remove("active")
    return


############################################################
qrreadermodule.read = ->
    log "qrreadermodule.read"
    return unless hasCamera

    currentReader.start()
    qrreaderBackground.classList.add("active")

    return

    
module.exports = qrreadermodule