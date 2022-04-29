# Bind files extensions with their respective commands
# alias -s py="python3 "
alias -s pdf="evince "
alias -s html="firefox "
alias -s php="$EDITOR "
alias -s ino="arduino "
alias -s js="$EDITOR "
alias -s json="$EDITOR "
# alias -s jpg="eog "
alias -s odt="libreoffice "
alias -s docx="libreoffice "
alias -s ogg="play"
alias -s db="sqlitebrowser"
# JP2A alias
alias -s jpg="jp2a --color"
# JP2A for png images setup
pngconvert (){
    convert $@ -quality 100 /tmp/image_preview.jpg && /tmp/image_preview.jpg && rm /tmp/image_preview.jpg -f
}
alias -s png="pngconvert"
