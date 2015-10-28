jsondsl = require('./../index.js').parse

json =
  div: 'foo'

console.log JSON.stringify json,null,2
console.log jsondsl( json )
process.exit 1 if jsondsl json != "<div>foo</div>"

json =
  div: 
    div: 
      div: 'foo'

console.log JSON.stringify json,null,2
console.log jsondsl( json )
process.exit 1 if jsondsl json != "<div><div><div>foo</div></div></div>"

json =
  foo: 'bar'
  div: 
    span: 
      div: 'foo'

console.log JSON.stringify json,null,2
console.log jsondsl( json )
process.exit 1 if jsondsl json != "<foo>bar</foo><div><span><div>foo</div></span></div>"
    
json =
  div: 
    div: 
      div: 'foo'

jsondsl = require('./../index.js')
jsondsl.parseKey = (k) -> k+"[%s]"
console.log jsondsl.parse json
process.exit 1 if jsondsl.parse json != "div[div[div[foo]]]"

console.log "tests ok"
