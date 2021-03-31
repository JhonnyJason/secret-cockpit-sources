indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.removeclientPopup = document.getElementById("removeclient-popup")
    global.clientToRemoveId = document.getElementById("client-to-remove-id")
    global.sharesecretPopup = document.getElementById("sharesecret-popup")
    global.sharesecretIdLine = document.getElementById("sharesecret-id-line")
    global.sharesecretToIdLine = document.getElementById("sharesecret-to-id-line")
    global.sharesecretOptionsContainer = document.getElementById("sharesecret-options-container")
    global.storeunsafePopup = document.getElementById("storeunsafe-popup")
    global.storeunsafeIdLine = document.getElementById("storeunsafe-id-line")
    global.storeunsafeAsLine = document.getElementById("storeunsafe-as-line")
    global.storeunsafeOptionsContainer = document.getElementById("storeunsafe-options-container")
    global.storesecretPopup = document.getElementById("storesecret-popup")
    global.storesecretIdLine = document.getElementById("storesecret-id-line")
    global.storesecretAsLine = document.getElementById("storesecret-as-line")
    global.storesecretOptionsContainer = document.getElementById("storesecret-options-container")
    global.deletesubspacePopup = document.getElementById("deletesubspace-popup")
    global.deletesubspaceId = document.getElementById("deletesubspace-id")
    global.addsubspacePopup = document.getElementById("addsubspace-popup")
    global.addsubspaceId = document.getElementById("addsubspace-id")
    global.easyAddOptionsContainer = document.getElementById("easy-add-options-container")
    global.deletesecretPopup = document.getElementById("deletesecret-popup")
    global.deleteSecretIdLine = document.getElementById("delete-secret-id-line")
    global.deleteSecretLine = document.getElementById("delete-secret-line")
    global.addsecretPopup = document.getElementById("addsecret-popup")
    global.addSecretIdLine = document.getElementById("add-secret-id-line")
    global.addSecretLine = document.getElementById("add-secret-line")
    global.editsecretPopup = document.getElementById("editsecret-popup")
    global.editSecretIdLine = document.getElementById("edit-secret-id-line")
    global.editSecretLine = document.getElementById("edit-secret-line")
    global.hiddenAliasTemplate = document.getElementById("hidden-alias-template")
    global.aliaspageContent = document.getElementById("aliaspage-content")
    global.aliasContainer = document.getElementById("alias-container")
    global.subspacepageContent = document.getElementById("subspacepage-content")
    global.sharedSecretsContainer = document.getElementById("shared-secrets-container")
    global.sharedFromIdLine = document.getElementById("shared-from-id-line")
    global.sharedFromAlias = document.getElementById("shared-from-alias")
    global.copySharedFromIdButton = document.getElementById("copy-shared-from-id-button")
    global.qrForSharedFromIdButton = document.getElementById("qr-for-shared-from-id-button")
    global.sharedToIdLine = document.getElementById("shared-to-id-line")
    global.sharedToAlias = document.getElementById("shared-to-alias")
    global.copySharedToIdButton = document.getElementById("copy-shared-to-id-button")
    global.qrForSharedToIdButton = document.getElementById("qr-for-shared-to-id-button")
    global.hiddenSecretTemplate = document.getElementById("hidden-secret-template")
    global.hiddenSubspaceTemplate = document.getElementById("hidden-subspace-template")
    global.secretspacepageContent = document.getElementById("secretspacepage-content")
    global.secretsContainer = document.getElementById("secrets-container")
    global.addSecretButton = document.getElementById("add-secret-button")
    global.subspacesContainer = document.getElementById("subspaces-container")
    global.addSubspaceButton = document.getElementById("add-subspace-button")
    global.idLine = document.getElementById("id-line")
    global.secretspacepageAlias = document.getElementById("secretspacepage-alias")
    global.copyIdButton = document.getElementById("copy-id-button")
    global.qrForIdButton = document.getElementById("qr-for-id-button")
    global.secretKeyLine = document.getElementById("secret-key-line")
    global.secretKeyHandleLine = document.getElementById("secret-key-handle-line")
    global.copySecretKeyButton = document.getElementById("copy-secret-key-button")
    global.qrForSecretKeyButton = document.getElementById("qr-for-secret-key-button")
    global.storeSecretKeyButton = document.getElementById("store-secret-key-button")
    global.removeClientButton = document.getElementById("remove-client-button")
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
    global.dataManagerInput = document.getElementById("data-manager-input")
    global.storeInUnsafeInput = document.getElementById("store-in-unsafe-input")
    global.storeInFloatingInput = document.getElementById("store-in-floating-input")
    global.storeInSignatureInput = document.getElementById("store-in-signature-input")
    global.keyloggerProtectionInput = document.getElementById("keylogger-protection-input")
    global.storeUnsafeInput = document.getElementById("store-unsafe-input")
    global.autodetectUnsafeInput = document.getElementById("autodetect-unsafe-input")
    global.identifyingEndingInput = document.getElementById("identifying-ending-input")
    global.content = document.getElementById("content")
    global.hiddenClientsDisplayTemplate = document.getElementById("hidden-clients-display-template")
    global.clientsDisplayContainer = document.getElementById("clients-display-container")
    global.aliasPageButton = document.getElementById("alias-page-button")
    global.inputUnsafeButton = document.getElementById("input-unsafe-button")
    global.inputFloatingButton = document.getElementById("input-floating-button")
    global.inputSignatureButton = document.getElementById("input-signature-button")
    global.headerRight = document.getElementById("header-right")
    return
    
module.exports = indexdomconnect