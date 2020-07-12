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

3. in shell scripts, use `read -n 1 -s -r -p "Press any key to continue"` to implement stop/contine actions

4. to search packages dependencies provides by `pkgconfig(Qt5Widgets) is needed by xxxx`
    ```
    The pkg-config files are usually provided by the -devel package so in most cases foo.pc is provided by libfoo-devel. That's still guesswork, but there are two shortcuts:

    Installing by path name, if you know where the .pc file will end up

    $> yum install /usr/lib64/pkgconfig/foo.pc
    That works for any file, but you still need to guess where the .pc file is. The best approach is using the actual pkgconfig requirement:

    $> yum install "pkgconfig(foo)"
    Use the quotes to avoid the shell trying to interpret the parenthesis.
    ```
