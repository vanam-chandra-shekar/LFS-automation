
{
    read
    while IFS=, read -r FILENAME VERSION MD5 URL; do
        LINK=${URL//@/$VERSION}
        FILE=$(basename "$LINK")
        DEST="$LFS/sources/$FILE"

        if [[ -f "$DEST" ]]; then
            
            if ! echo "$MD5 $DEST" | md5sum -c -; then
                rm -f "$DEST"
            else
                continue
            fi
            
        fi

        echo "Downloading $LINK"
        wget -P "$LFS/sources" "$LINK" || exit 1
        
        if ! echo "$MD5 $DEST" | md5sum -c -; then
            echo "MD5 mismatch for $FILE - deleting"
            rm -f "$DEST"
            exit 1
        fi
        echo "MD5 matched for $FILE"
        
    done
} < packages.csv 
