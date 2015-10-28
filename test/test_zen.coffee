dsl = require('./../index.js')
zen = require 'zen-coding'

dsl.parseKey   = (k)      -> zen k+'>{%s}'
dsl.parseValue = (v,data) -> data[v]

json = 
  'div#foo.flop>fieldset>div>ul': 
    'li.one>a[href="/"]': 'one'
    'li.two>a[href="/"]': 'two'

data = {'one':'hello', 'two': 'world'}
      
console.log JSON.stringify json,null,2
console.log dsl.parse json,data
