## general regex notes
- \d 匹配数字
- \D 匹配非数字字符
- \w 单词字符　　等于［＿a-zA-Z0-9］
- \W 非单词字符   等于空格　标点　及非字符　非数字
- \O 空字符
- \s 空白符
- \h 水平空白符
- \H 非水平空白符
- \S 非空字符
- [\b] 退格字符
- \b 单词边界
- \r 回车
- \t　TAB 制表符
- \v  垂直制表符
- \V　非垂直制表符
- \n  换行
- . 任意字符
- + 一个或多个
- *　零个或多个　

## perl regex examples
- perl replace characters:
    ```sh

        perl -pi -e  'if (($. =/^passwd/) && ($. !=/ldap/)) {s/$/\ ldap/}' -e 'if (($. =/^group/) && ($. != /ldap/)) {s/$/\ ldap/}'   /tmp/nsswitch.dns
    ```
- ```$. ```: current line

## shell regex examples
- search shell and sql files: 
    ``` sh

    find /data -type f -iregex  '.*\.\(sh\|sql\)' 
    ```