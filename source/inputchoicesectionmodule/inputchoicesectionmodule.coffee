############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("inputchoicesectionmodule")
#endregion

############################################################
export initialize = ->
    log "initialize"
    unsafeInput = allModules.unsafeinputpagemodule
    floatingInput = allModules.floatinginputpagemodule
    
    inputUnsafeButton.addEventListener("click", unsafeInput.slideIn)
    inputFloatingButton.addEventListener("click", floatingInput.slideIn)
    return
    
