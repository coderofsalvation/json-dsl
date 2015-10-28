<img alt="" src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/JSON_vector_logo.svg/2000px-JSON_vector_logo.svg.png" width="120px"/>

Generate your own minilanguages fast using json as a startingpoint.
No parsetrees, no lexical analyzers, just plain json.

# Usage

    $ npm install json-dsl

in your code

    jdsl = require('json-dsl').parse
    output = jdsl( yourjson )

# basics: xml

By default nested json is converted into xml

    {
      "div": {
        "div": {
          "div": "foo"
        }
      }
    }

gets converted into 

    <div><div><div>foo</div></div></div>

# customize key evaluation

lets evaluate the keys in a different way:

    jsondsl = require('json-dsl')
    jsondsl.parseKey = function(k) {
      return k + "[%s]";
    };
    output = jdsl( yourjson )

output:

    div[div[div[foo]]]

# customize value evaluation

lets take the previous example and lets add `parseValue`

    data = { foo: "bar" }
    jsondsl.parseValue = function(v,data) {
      return data[v]
    }
    output = jdsl( yourjson, data )
    
output:

    div[div[div[bar]]]

# example: html template language

> NOTE: the dsl below is a stripped down version of the [brown](https://npmjs.org/packages/brown) template engine, a hyperminimalistic template dsl which borrows from emmet and mustache.

setup dsl:

    var jdsl = require('json-dsl');
    var zen = require('zen-coding');
  
    jdsl.parseKey = function(k) {
      return zen(k + '>{%s}');
    };
  
    jdsl.parseValue = function(v, data) {
      return data[v];
    };

lets test it:
  
    var json = {
      'div#foo.flop>fieldset>div>ul': {
        'li.one>a[href="/"]': 'one',
        'li.two>a[href="/"]': 'two'
      }
    };
  
    var data = {
      'one': 'hello',
      'two': 'world'
    };
  
    console.log(JSON.stringify(json, null, 2));
    console.log(jdsl.parse(json, data));

outputs:

    <div id="foo" class="flop"><fieldset><div><ul><li class="one"><a href="/">hello</a></li><li class="two"><a href="/">world</a></li></ul></div></fieldset></div>

