### Class Diagram

```uml

@startuml

  Class Agent

@enduml

```

### Sequence Diagram

#### Setup

```uml

@startuml

    Controller -> Agent ++ : Register
    Agent -> Client ++ : register
    Client -> Client ++ : initConnection
    alt [ new conn ]
        Client -> Client ++ : connect
        Client -> MuxServer ++ : go Serve()
            MuxServer -> MuxServer ++ : serveConn
        deactivate Client 
    else
    end
    deactivate Client

    Client -> Client ++: go keepConnect() 
    deactivate Client

    Client -> Agent -- : return

    Agent -> Controller -- : return

@enduml


```

#### Request Serving

```uml

@startuml
    [-> MuxServer ++ : serveConn()
        MuxServer -> Conn ++ : HandleMessage
            loop
                alt Conn.ctx.Done()
                    Conn -> MuxServer : return nil
                else
                    MuxServer -> ConcurrencyPool ++ : BorrowOrWait
                    return get token
                    MuxServer -> Dispatcher ++ : Dispatch
                    Dispatcher -> MuxServer -- : return
                end
            end
        MuxServer -> MuxServer ++ : log init error if necessary
    deactivate MuxServer
@enduml

```
