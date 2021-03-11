indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.hiddenSecretTemplate = document.getElementById("hidden-secret-template")
    global.secretspacepageContent = document.getElementById("secretspacepage-content")
    global.secretsContainer = document.getElementById("secrets-container")
    global.addSecretButton = document.getElementById("add-secret-button")
    global.idLine = document.getElementById("id-line")
    global.secretLine = document.getElementById("secret-line")
    global.typeLine = document.getElementById("type-line")
    global.signatureinputpageContent = document.getElementById("signatureinputpage-content")
    global.signatureSecretInput = document.getElementById("signature-secret-input")
    global.floatinginputpageContent = document.getElementById("floatinginputpage-content")
    global.floatingSecretInput = document.getElementById("floating-secret-input")
    global.floatingIdLine = document.getElementById("floating-id-line")
    global.unsafeinputpageContent = document.getElementById("unsafeinputpage-content")
    global.unsafeSecretInput = document.getElementById("unsafe-secret-input")
    global.unsafeIdLine = document.getElementById("unsafe-id-line")
    global.scanQrButton = document.getElementById("scan-qr-button")
    global.createUnsafeButton = document.getElementById("create-unsafe-button")
    global.settingspageContent = document.getElementById("settingspage-content")
    global.secretManagerInput = document.getElementById("secret-manager-input")
    global.keyloggerProtectionInput = document.getElementById("keylogger-protection-input")
    global.content = document.getElementById("content")
    global.hiddenClientsDisplayTemplate = document.getElementById("hidden-clients-display-template")
    global.clientsDisplayContainer = document.getElementById("clients-display-container")
    global.inputUnsafeButton = document.getElementById("input-unsafe-button")
    global.inputFloatingButton = document.getElementById("input-floating-button")
    global.inputSignatureButton = document.getElementById("input-signature-button")
    global.headerRight = document.getElementById("header-right")
    return
    
module.exports = indexdomconnect