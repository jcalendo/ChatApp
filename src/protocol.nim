import json


type
  Message* = object
    username*: string
    message*: string

proc createMessage*(username, message: string): string =
  result = $(%{
    "username": %username,
    "message": %message
    }) & "\c\l"

proc parseMessage*(data: string): Message =
  let dataJson = parseJson(data)
  result.username = dataJson["username"].getStr()
  result.message = dataJson["message"].getStr()

when isMainModule:
  block:
    let data = """{"username" : "Gennaro", "message" : "Hi!"}"""
    let parsed = parseMessage(data)
    doAssert parsed.username == "Gennaro"
    doAssert parsed.message == "Hi!"
  block:
    let expected = """{"username":"Gennaro","message":"Hello"}""" & "\c\l"
    doAssert createMessage("Gennaro", "Hello") == expected
  echo "All tests passed!"
