
FAILED=0

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
        if ! wget -P "$LFS/sources" "$LINK"; then
            echo "Download Failed: $DEST - skipping"
            ((FAILED+=1))
            continue
        fi
        
        if ! echo "$MD5 $DEST" | md5sum -c -; then
            echo "MD5 mismatch for $FILE - deleting"
            rm -f "$DEST"
            exit 1
        fi
        echo "MD5 matched for $FILE"
        
    done
} < packages.csv 


if [[ $FAILED -ne 0 ]]; then
    "All Packages Not Installed Quitting"
    exit 1
fi
