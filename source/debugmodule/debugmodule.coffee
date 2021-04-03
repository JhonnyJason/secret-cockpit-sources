debugmodule = {name: "debugmodule", uimodule: false}

#####################################################
debugmodule.initialize = () ->
    # console.log "debugmodule.initialize - nothing to do"
    return

debugmodule.modulesToDebug = 
    unbreaker: true
    # aliaspagemodule: true
    # addsubspacepopupmodule: true
    # clientstoremodule: true
    # configmodule: true
    # editsecretpopupmodule: true
    # idaliasmodule: true
    # qrdisplaymodule: true
    # qrreadermodule: true
    # unsafeinputpagemodule: true
    # floatinginputpagemodule: true
    # clientsdisplaymodule: true
    # secretspacepagemodule: true
    # sharesecretpopupmodule: true
    # storesecretpopupmodule: true
    # storeunsafepopupmodule: true
    # subspacepagemodule: true

export default debugmodule
