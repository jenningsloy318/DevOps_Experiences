jq -- command to extract fields from json
---

1. extract muliple fields as strings

users.json:
```json
{
    "users": [
        {
            "first": "Stevie",
            "last": "Wonder"
        },
        {
            "first": "Michael",
            "last": "Jackson"
        }
    ]
}
```

```shell
#cat users.json | jq '.users[]|.first'

"Stevie"
"Michael"
```


2. extract muliple fields as new json/dict
```shell
#cat users.json | jq '{.users[]|{"first":.first}}'
{
  "first": "Stevie"
}
{
  "first": "Michael"
}
```