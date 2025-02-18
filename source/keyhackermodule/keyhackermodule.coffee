############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("keyhackermodule")
#endregion

############################################################
import * as utl from "./utilsmodule.js"
# import * as clientFactory from "secret-manager-client"
import * as secUtl  from "secret-manager-crypto-utils"

batchSize = 5000

############################################################
allQWERTZchars = [
  " ", "!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/",
  "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ";", "<", "=", ">", "?", 
  "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", 
  "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "\\", "]", "^", "_", 
  "`", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", 
  "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "{", "|", "}", "~", 
  "ä", "ö", "ü", "ß", "Ä", "Ö", "Ü"
];

likelyQWERTZchars = [
    "c", "x", "d", "f", "v", "C", "X", "D", "F", "V", "h", "g", "z", "u", "j", "n", "b", "H", "G", "Z", "U", "J", "N", "B", "o", "i", "9", "0", "p", "l", "k", "O", "I", ")", "=", "P", "L", "K", 
    "s", "S", "e", "E", "r", "R", "8", "(", "1", "!", "^", "°", "2", '"', "q", "Q", "7", "/", "4", "$", "3", "§", "r", "R", "5", "%", "ß", "?"
]


############################################################
chars = null
useAllChars = false

############################################################
latestPercent = 101

############################################################
# Char Missing Options
getSingleCharMissingOptions = (phrase) ->
    options = []
    for c,i in phrase
        front = phrase.slice(0,i)
        back = phrase.slice(i+1)
        options.push("#{front}#{back}")
    return options

getDoubleCharMissingOptions = (phrase) ->
    options = []
    opts = getSingleCharMissingOptions(phrase)
    for phrase in opts
        subOpts = getSingleCharMissingOptions(phrase)
        for so in subOpts
            options.push(so)
    return options

# Typo Options
getSingleTypoOptions = (phrase) ->
    options = []
    for c,i in phrase
        front = phrase.slice(0,i)
        back = phrase.slice(i+1)
        for char in chars
            options.push("#{front}#{char}#{back}")
    return options

getDoubleTypoOptions = (phrase) ->
    options = []
    typoOptions = getSingleTypoOptions(phrase)
    for typoOption in typoOptions
        opts = getSingleTypoOptions(typoOption)
        options.push(o) for o in opts
    return options

getTripleTypoOptions = (phrase) ->
    options = []
    typoOptions = getDoubleTypoOptions(phrase)
    for typoOption in typoOptions
        opts = getSingleTypoOptions(typoOption)
        options.push(o) for o in opts
    return options

# Char Added Options
getSingleCharAddOptions = (phrase) ->
    options = []
    for c,i in phrase
        front = phrase.slice(0,i)
        back = phrase.slice(i)
        for char in chars
            options.push("#{front}#{char}#{back}")
    return options

getDoubleCharAddOptions = (phrase) ->
    options = []
    singleAdded = getSingleCharAddOptions(phrase)
    for phrase in singleAdded
        opts = getSingleCharAddOptions(phrase)
        options.push(o) for o in opts
    return options

# General Combinations
## pwd+0 typo 1

## pwd+0 typo 2

## pwd+0 typo 3


## pwd+1 typo 1
getSingleAddedCharPlusSingleTypoOptions = (phrase) ->
    options = []
    typoOptions = getSingleTypoOptions(phrase)
    for typoOption in typoOptions
        opts = getSingleCharAddOptions(typoOption)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options

## pwd+1 typo 2
getSingleAddedCharPlusDoubleTypoOptions = (phrase) ->
    options = []
    typoOptions = getDoubleTypoOptions(phrase)
    for phrase,i in typoOptions
        opts = getSingleCharAddOptions(phrase)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options

## pwd+1 typo 3
getSingleAddedCharPlusTripleTypoOptions = (phrase) ->
    options = []
    typoOptions = getTripleTypoOptions(phrase)
    for phrase in typoOptions
        opts = getSingleCharAddOptions(phrase)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options
    #     options.push(o) for o in opts
    # return options

## pwd+2 typo 1
getDoubleAddedCharPlusSingleTypoOptions = (phrase) ->
    options = []
    typoOptions = getSingleTypoOptions(phrase)
    for phrase in typoOptions
        opts = getDoubleCharAddOptions(phrase)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options

## pwd+2 typo 2
getDoubleAddedCharPlusDoubleTypoOptions = (phrase) ->
    options = []
    typoOptions = getDoubleTypoOptions(phrase)
    for phrase in typoOptions
        opts = getDoubleCharAddOptions(phrase)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options

## pwd+2 typo 3
getDoubleAddedCharPlusTripleTypoOptions = (phrase) ->
    options = []
    typoOptions = getTripleTypoOptions(phrase)
    for phrase in typoOptions
        opts = getDoubleCharAddOptions(phrase)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options

## pwd-1 typo 1
getSingleMissingCharPlusSingleTypoOptions = (phrase) ->
    options = []
    charMissingOptions = getSingleCharMissingOptions(phrase)
    for phrase in charMissingOptions
        opts = getSingleTypoOptions(phrase)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options


## pwd-1 typo 2
getSingleMissingCharPlusDoubleTypoOptions = (phrase) ->
    options = []
    charMissingOptions = getSingleCharMissingOptions(phrase)
    for phrase in charMissingOptions
        opts = getDoubleTypoOptions(phrase)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options

## pwd-1 typo 3
getSingleMissingCharPlusTripleTypoOptions = (phrase) ->
    options = []
    charMissingOptions = getSingleCharMissingOptions(phrase)
    for phrase in charMissingOptions
        opts = getTripleTypoOptions(phrase)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options


## pwd-2 typo 1
getDoubleMissingCharPlusSingleTypoOptions = (phrase) ->
    options = []
    charMissingOptions = getDoubleCharMissingOptions(phrase)
    for phrase in charMissingOptions
        opts = getSingleTypoOptions(phrase)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options


## pwd-2 typo 2
getDoubleMissingCharPlusDoubleTypoOptions = (phrase) ->
    options = []
    charMissingOptions = getDoubleCharMissingOptions(phrase)
    for phrase in charMissingOptions
        opts = getDoubleTypoOptions(phrase)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options

## pwd-2 typo 3
getDoubleMissingCharPlusTripleTypoOptions = (phrase) ->
    options = []
    charMissingOptions = getDoubleCharMissingOptions(phrase)
    for phrase in charMissingOptions
        opts = getTripleTypoOptions(phrase)
        for o in opts
            options.push(o) 
            if options.length == batchSize
                yield options
                options = []
    yield options



############################################################
generateOptions = (phrase) ->
    log "generateOptions"
    options = []

    # All Double Typo Options
    # opts = getDoubleMissingCharPlusDoubleTypoOptions(phrase)
    # options.push(o) for o in opts 

    # opts = getSingleMissingCharPlusDoubleTypoOptions(phrase)
    # options.push(o) for o in opts 

    # opts = getDoubleTypoOptions(phrase)
    # options.push(o) for o in opts

    yield from getSingleAddedCharPlusDoubleTypoOptions(phrase)

    # opts = getSingleAddedCharPlusDoubleTypoOptions(phrase)
    # options.push(o) for o in opts

    # opts = getDoubleAddedCharPlusDoubleTypoOptions(phrase)
    # options.push(o) for o in opts

    log "generatedOptions #{options.length}"
    return options

############################################################
logPercentProgress = (now, total) ->
    percent = 100 * now / total
    percent = Math.floor(percent)
    if percent != latestPercent
        log "Progress: #{percent}%"
        latestPercent = percent
    return

############################################################
produceIdForPhrase = (phrase) ->
    # log "produceIdForPhrase"
    key = await utl.seedToKey(phrase)
    return await secUtl.createPublicKey(key)

############################################################
processBatch = (batch, targetId) ->
    prms = (produceIdForPhrase(phrase) for phrase in batch)        
    batchResult = await Promise.all(prms)
    
    targetResult = getTargetResult(batch, batchResult, targetId)
    if targetResult? then return targetResult
    return null

getTargetResult = (batch, batchResult, targetId) ->
    for id,i in batchResult when id.startsWith(targetId) 
        return { phrase: batch[i], id }
    return null

############################################################
export recoverKey =  (basePhrase, targetId) ->
    log "recoverKey"
    if useAllChars then chars = allQWERTZchars
    else chars = likelyQWERTZchars

    optionsGenerator = generateOptions(basePhrase)

    for options from optionsGenerator
        targetResults = await processBatch(options, targetId)
        if targetResult? then return targetResult
        log "batch processed - not found..."

    return null

