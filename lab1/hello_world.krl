ruleset hello_world {
  meta {
    name "Hello World"
    description <<
A first ruleset for the Quickstart
>>
    author "Allison Bellows"
    logging on
    shares hello, monkey, __testing
  }
  
  global {
    hello = function(obj) {
      msg = "Hello " + obj;
      msg
    }

    monkey = function(name) {
      name.defaultsTo("Monkey");
      msg = "Hello " + name;
      msg
    }

    __testing = { "queries": [ { "name": "hello", "args": [ "obj" ] },
                              { "name": "monkey", "args": [ "name" ]},
                              { "name": "__testing" }],
                  "events": [ { "domain": "echo", "type": "hello" ,
                                "attrs": [ "name" ] },
                              { "domain": "echo", "type": "monkey" ,
                                "attrs": [ "name" ] } ]
                }
  }

  rule hello_monkey {
    select when echo monkey

    pre {
      name = event:attr("name").defaultsTo("Monkey").klog("our passed in name: ")
    }
    send_directive("say", {"something": "Hello Monkey"})
  }
  
  rule hello_world {
    select when echo hello

    pre {
      name = event:attr("name").klog("our passed in name: ")
    }
    send_directive("say", {"something": "Hello World"})
  }
  
}