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
 also we can use regex, find fields which first name contains `M`
 ```shell
 # cat users.json |jq -r  '.users[]|select(.first|test(".*M.*"))'
 {
  "first": "Michael",
  "last": "Jackson"
  }

 #cat users.json |jq -r  '.users[]|select(.first|test(".*M.*"))|.last'
 Jackson
 ```
  another example `project.json`
  ```json
  {
    "projects": [
      {
        "projectId": 4407472,
        "projectName": "acb-dev",
        "projectToken": "585742c994f74949dbbbcd987ea94"
      },
      {
        "projectId": 4422028,
        "projectName": "acb-2108",
        "projectToken": "3d5bc26696d846af82e37d512a2976"
      },
      {
        "projectId": 4422029,
        "projectName": "acb-test",
        "projectToken": "3d5bc26696d846af82e37d512a2946"
      },
      {
        "projectId": 4422030,
        "projectName": "bcd-dev",
        "projectToken": "3d5bc26696d846af82e37d512a2974"
      },
      {
        "projectId": 4422031,
        "projectName": "bcd-test",
        "projectToken": "3d5bc26696d846af82e37d512a2974"
      },
      {
        "projectId": 4422032,
        "projectName": "bcd-2108",
        "projectToken": "3d5bc26696d846af82e37d512c2974"
      }
    ],
    "platform": "aws"
  }
  ```
  ```shell
  # cat project.json|jq  -r '.projects[] |select(.projectName|test(".*acb.*"))|select(.projectName|test(".*^(dev|2108)$"))'
  {
    "projectId": 4407472,
    "projectName": "acb-dev",
    "projectToken": "585742c994f74949dbbbcd987ea94"
  }
  {
    "projectId": 4422028,
    "projectName": "acb-2108",
    "projectToken": "3d5bc26696d846af82e37d512a2976"
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
5 youtube_dl option ` -o '%(playlist_index)s - %(title)s.%(ext)s' -f bestvideo+bestaudio/best --write-sub --write-auto-sub --embed-subs` for playlist with subtitle embeded