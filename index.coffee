module.exports = ( () ->

  @.opts =
    token: "%s"
  @.parseKey   = (k) -> "<"+k+">%s</"+k+">"
  @.parseValue = (v,d) -> v

  @.parseDSL = (json,data,str) ->
    str = '' if not str?
    if typeof json is "object"
      for k,v of json
        nk = @.parseKey k
        nv = @.parse v, data, ''
        str += nk.replace /%s/, nv
    if typeof json is "string"
      str += @.parseValue json, data
    if not str?
      return json
    else return str
  
  @.parse = (json,data) ->
    @.parseDSL json,data
  
  return @

)()
