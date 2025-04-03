
DOWNLOADS_DIR="$HOME/Downloads"

# repertoires de tri
DOCUMENTS_DIR="$DOWNLOADS_DIR/Documents"
IMAGES_DIR="$DOWNLOADS_DIR/Images"
VIDEOS_DIR="$DOWNLOADS_DIR/Videos"
ARCHIVES_DIR="$DOWNLOADS_DIR/Archives"
CODE_DIR="$DOWNLOADS_DIR/Code"
SSH_DIR="$DOWNLOADS_DIR/SSH"
MUSIC_DIR="$DOWNLOADS_DIR/Music"
PRES_DIR="$DOWNLOADS_DIR/Presentations"
INSTALL_DIR="$DOWNLOADS_DIR/Install"
MINECRAFT_DIR="$DOWNLOADS_DIR/Minecraft"
NETWORK_DIR="$DOWNLOADS_DIR/Network"
ROM_DIR="$DOWNLOADS_DIR/ROM"
LOGS_DIR="$DOWNLOADS_DIR/Logs"

mkdir -p "$DOCUMENTS_DIR" "$IMAGES_DIR" "$VIDEOS_DIR" "$ARCHIVES_DIR" "$CODE_DIR" "$SSH_DIR" "$MUSIC_DIR" "$PRES_DIR" "$INSTALL_DIR" "$MINECRAFT_DIR" "$NETWORK_DIR" "$ROM_DIR" "$LOGS_DIR"

echo "Début du tri des fichiers..."

#mode insensible a la casse 
shopt -s nocasematch 

for file in "$DOWNLOADS_DIR"/*; do
  if [[ -f "$file" ]]; then
    extension="${file##*.}"

    if [[ -z "$extension" ]]; then
      echo "Fichier sans extension ignoré : $file"
      continue
    fi

    echo "Fichier trouvé : $file (extension: $extension)"

    case "$extension" in
      pdf|docx|txt|ppt|xls|pages)
        target_dir="$DOCUMENTS_DIR"
        ;;
      jpg|png|gif|jpeg|heic|svg|webp|mov|ico|avif)
        target_dir="$IMAGES_DIR"
        ;;
      mp4|mkv|avi|m3u8)
        target_dir="$VIDEOS_DIR"
        ;;
      zip|tar|gz|rar|7z|bz2|tgz)
        target_dir="$ARCHIVES_DIR"
        ;;
      html|json|css|js|xml|py|java|cpp|c|sh|sql|yaml|yml|php|rb|pl|go|swift|rs|kt|md|ipynb|jsx|phar|pyc)
        target_dir="$CODE_DIR"
        ;;
      ppk|pem|key|pub|crt)
        target_dir="$SSH_DIR"
        ;;
      mp3)
        target_dir="$MUSIC_DIR"
        ;;
      pptx|pptm|ppta|potx|potm|pot|ppsx|ppsm|ppsa)
        target_dir="$PRES_DIR"
        ;;
      dmg|exe|pkg)
        target_dir="$INSTALL_DIR"
        ;;
      jar)
        target_dir="$MINECRAFT_DIR"
        ;;
      pka)
        target_dir="$NETWORK_DIR"
        ;;
      nds|smc|gba|n64|iso|rom)
        target_dir="$ROM_DIR"
        ;;
      log)
        target_dir="$LOGS_DIR"
        ;;
      ds_store|thumbs.db)
        echo "Suppression du fichier système : $file"
        rm -f "$file"
        continue
        ;;
      *)
        echo "Fichier non pris en charge : $file"
        target_dir=""
        ;;
    esac


    if [[ -d "$target_dir" ]]; then
      if mv "$file" "$target_dir"; then
        echo "mooved to $target_dir"
      else
        echo "Erreur avec $file"
      fi
    else
      echo " le dossier cible $target_dir n'exsiste pas"
    fi
  fi
done

echo "Tri done"
