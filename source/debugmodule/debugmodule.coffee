debugmodule = {name: "debugmodule", uimodule: false}

#####################################################
debugmodule.initialize = () ->
    # console.log "debugmodule.initialize - nothing to do"
    return

debugmodule.modulesToDebug = 
    unbreaker: true
    # addsubspacepopupmodule: true
    # clientstoremodule: true
    # configmodule: true
    # editsecretpopupmodule: true
    # unsafeinputpagemodule: true
    # floatinginputpagemodule: true
    # clientsdisplaymodule: true
    # secretspacepagemodule: true
    # storesecretpopupmodule: true
    storeunsafepopupmodule: true
    # subspacepagemodule: true

export default debugmodule
