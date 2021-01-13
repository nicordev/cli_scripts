#! /bin/bash

suffix="nicor"

if [ -n "$1" ]; then
    suffix="$1"
fi

createExecutableFile() {
    touch "$1"
    chmod +x "$1"
}

writeScriptTemplate() {
    cat > "$1" <<END
#! /bin/bash

SCRIPT_NAME=\$(basename \$0)

functionName() {
    echo -e "\e[32m Welcome home! \e[0m \n You are executing: \e[33m \${FUNCNAME[0]} \e[0m with \$# parameter(s)"
}

_listAvailableFunctions() {
    cat \$0 | grep -E '^[a-z]+[a-zA-Z0-9]*\(\) \{$' | sed 's#() {\$##'
}

if [ \$# -eq 0 ]; then
    _listAvailableFunctions
    exit
fi

\$@
END
}

fileName="please_${suffix}.sh"

if [ -f "$fileName" ]; then
    echo -e "file \e[33m$fileName\e[0m already exists.\n\nPlease remove it first:\n\e[33mrm $fileName\e[0m"
    exit 1
fi

echo "Creating script ${fileName}..."
createExecutableFile "$fileName"
writeScriptTemplate "$fileName"
echo -e "Done. \e[32mEnjoy!\e[0m"