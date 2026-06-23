
## About versionFinder

versionFinder is a python script based on [LinkFinder](https://github.com/GerbenJavado/LinkFinder) and versionFinder (https://github.com/m4ll0k/versionFinder), written for detecting patterns / regex of technology versions displayed in JavaScript files. It does so by using jsbeautifier for python in combination with a fairly large regular expression. The regular expressions consists of four small regular expressions. These are responsible for finding and search anything on js files.



## Help

```
usage: versionFinder.py [-h] [-e] -i INPUT [-o OUTPUT] [-r REGEX] [-b]
                       [-c COOKIE] [-g IGNORE] [-n ONLY] [-H HEADERS]
                       [-p PROXY]

optional arguments:
  -h, --help            show this help message and exit
  -e, --extract         Extract all javascript links located in a page and
                        process it
  -i INPUT, --input INPUT
                        Input a: URL, file or folder
  -o OUTPUT, --output OUTPUT
                        Where to save the file, including file name. Default:
                        output.html
  -r REGEX, --regex REGEX
                        RegEx for filtering purposes against found endpoint
                        (e.g: ^/api/)
  -b, --burp            Support burp exported file
  -c COOKIE, --cookie COOKIE
                        Add cookies for authenticated JS files
  -g IGNORE, --ignore IGNORE
                        Ignore js url, if it contain the provided string
                        (string;string2..)
  -n ONLY, --only ONLY  Process js url, if it contain the provided string
                        (string;string2..)
  -H HEADERS, --headers HEADERS
                        Set headers ("Name:Value\nName:Value")
  -p PROXY, --proxy PROXY
                        Set proxy (host:port)

```

## Installation

versionFinder supports Python 3.

```
$ git clone https://github.com/amaurypetrini/versionFinder.git versionFinder
$ cd versionFinder
$ python -m pip install -r requirements.txt or pip install -r requirements.txt
$ python3 versionFinder.py
```

## Usage

- Most basic usage to find the sensitive data with default regex in an online JavaScript file and output the HTML results to results.html:

`python3 versionFinder.py -i https://example.com/1.js -o results.html`

- CLI/STDOUT output (doesn't use jsbeautifier, which makes it very fast):

`python3 versionFinder.py -i https://example.com/1.js -o cli`

- Analyzing an entire domain and its JS files:

`python3 versionFinder.py -i https://example.com/ -e`

- Ignore certain js file (like external libs) provided by `-g --ignore`

`python3 versionFinder.py -i https://example.com/ -e -g 'jquery;bootstrap;api.google.com'`

- Process only certain js file provided by `-n --only`:

`python3 versionFinder.py -i https://example.com/ -e -n 'd3i4yxtzktqr9n.cloudfront.net;www.myexternaljs.com'`

- Use your regex:

`python3 versionFinder.py -i https://example.com/1.js -o cli -r 'apikey=my.api.key[a-zA-Z]+'`

- Other options: add headers,proxy and cookies:

``python3 versionFinder.py -i https://example.com/ -e -o cli -c 'mysessionid=111234' -H 'x-header:value1\nx-header2:value2' -p 127.0.0.1:8080 -r 'apikey=my.api.key[a-zA-Z]+'``

- Input accept all this entries:

 - Url: e.g. https://www.google.com/ [-e] is required
 - Js url: e.g. https://www.google.com/1.js
 - Folder: e.g. myjsfiles/*
 - Local file: e.g /js/myjs/file.js




## add Regex

- Open `versionFinder.py` and add your regex:

```py
_regex = {
    'js_version_generic' : r'(?i)(?:version|v)\s*[:=]?\s*["\']?\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?["\']?',
    'npm_inline_version' : r'["\'][a-zA-Z0-9_.-]+@(\d+\.\d+\.\d+)["\']',
    'cdn_js_library_version' : r'(?:https?:)?\/\/[^\/]+\/[^\/]*(?:jquery|react|vue|angular|lodash|bootstrap)[^\/]*\/(\d+\.\d+\.\d+)',
    'window_object_version' : r'window\.[a-zA-Z0-9_$]+\s*=\s*\{[^}]*version\s*:\s*["\']\d+\.\d+\.\d+["\']',
    'package_json_inline_version' : r'"(?:dependencies|devDependencies)"\s*:\s*\{[^}]*"[^"]+"\s*:\s*"[\^~]?\d+\.\d+\.\d+[^"]*"',
    'import_require_version' : r'from\s+[\'"][^\'"]+[\'"]\s*\(\s*[\'"]?\d+\.\d+\.\d+[\'"]?\s*\)',
    'npm_scoped_version' : r'["\'][a-zA-Z0-9_.-]+@(\d+\.\d+\.\d+)["\']',
    'cdn_lib_version_alt' : r'(jquery|react|vue|angular|lodash).*?(\d+\.\d+\.\d+)',
}

```
