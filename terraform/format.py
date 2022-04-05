
## python format.py deployName=app deployNamespace=namespace

import sys

deployName = ""
deployNamespace = ""

for i in sys.argv:
    if "deployName" in i:
        deployName = i.split("=")[1]
    if "deployNamespace" in i:
        deployNamespace = i.split("=")[1]

assert deployNamespace != ""
assert deployName != ""

with open("main.template", "r") as src:
    with open("main.tf", "w") as dst:
        dst.write(src.read().replace("{{deployName}}", deployName)
        .replace("{{deployNamespace}}", deployNamespace))



