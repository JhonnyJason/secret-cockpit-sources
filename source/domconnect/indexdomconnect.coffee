indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.settingspageContent = document.getElementById("settingspage-content")
    global.secretManagerInput = document.getElementById("secret-manager-input")
    global.content = document.getElementById("content")
    global.headerRight = document.getElementById("header-right")
    return
    
module.exports = indexdomconnect