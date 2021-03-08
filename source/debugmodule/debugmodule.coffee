debugmodule = {name: "debugmodule", uimodule: false}

#####################################################
debugmodule.initialize = () ->
    # console.log "debugmodule.initialize - nothing to do"
    return

debugmodule.modulesToDebug = 
    unbreaker: true
    # configmodule: true
    # unsafeinputpagemodule: true
    # floatinginputpagemodule: true
    secretsdisplaymodule: true
    secretspacepagemodule: true

export default debugmodule
