indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.signatureinputpageContent = document.getElementById("signatureinputpage-content")
    global.signatureSecretInput = document.getElementById("signature-secret-input")
    global.floatinginputpageContent = document.getElementById("floatinginputpage-content")
    global.floatingSecretInput = document.getElementById("floating-secret-input")
    global.unsafeinputpageContent = document.getElementById("unsafeinputpage-content")
    global.unsafeSecretInput = document.getElementById("unsafe-secret-input")
    global.settingspageContent = document.getElementById("settingspage-content")
    global.secretManagerInput = document.getElementById("secret-manager-input")
    global.keyloggerProtectionInput = document.getElementById("keylogger-protection-input")
    global.content = document.getElementById("content")
    global.inputUnsafeButton = document.getElementById("input-unsafe-button")
    global.inputFloatingButton = document.getElementById("input-floating-button")
    global.inputSignatureButton = document.getElementById("input-signature-button")
    global.headerRight = document.getElementById("header-right")
    return
    
module.exports = indexdomconnect