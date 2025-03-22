#!/bin/bash

FILE=~/p/m/t/c/main.tex
CACHE_DIR=~/.cache/latex-workflows
CHAPTER_CACHE="$CACHE_DIR/chapter-history.txt"

mkdir -p "$CACHE_DIR"

# Single AWK pass to capture titles and line numbers
declare -A chapters ready_chapters
declare -a indexed_chapters merged_chapters

num_lines=$(wc -l <"$FILE")

while IFS=$'\t' read -r chapter line; do
    indexed_chapters+=("$chapter")
    chapters["$chapter"]="$line"
done < <(awk '
    /\\chapter{/ {
        # Clean title and print as "TITLE\tLINE_NUM"
        gsub(/^.*\\chapter{ *| *}.*$/, "");
        print $0 "\t" NR
    }
' "$FILE")

if [[ -f "$CHAPTER_CACHE" ]]; then
    while IFS= read -r cached_chapter; do
        if [[ -n "${chapters["$cached_chapter"]}" ]]; then
            ready_chapters["$cached_chapter"]=1
            merged_chapters+=("$cached_chapter")
        fi
    done <"$CHAPTER_CACHE"
fi

for chapter in "${indexed_chapters[@]}"; do
    [[ -z "${ready_chapters["$chapter"]}" ]] && merged_chapters+=("${chapter}")
done
echo "${merged_chapters[@]}"

options=("add admission test problem")
chosen=$(printf "%s\n" "${options[@]}" | rofi -dmenu -i -markup -p "latex")

# Execute the chosen option
# TODO: improve input handling. some sort of list where all steps are defined as objects,
# and some recursive function goes through them showing a prompt for each
case "$chosen" in
"add admission test problem")
    problem_num=$(rofi -dmenu -i -markup -p "num")

    if [ -n "$problem_num" ]; then
        chapter_chosen=$(printf "%s\n" "${merged_chapters[@]}" | rofi -dmenu -i -markup -p "chap")

        if [ -n "$chapter_chosen" ]; then
            temp_file=$(mktemp)
            cat "$temp_file"
            (
                echo "$chapter_chosen"
                printf "%s\n" "${merged_chapters[@]}" | awk '
                    $0 != "'"$chapter_chosen"'" {print}
                '
            ) >"$temp_file"
            mv "$temp_file" "$CHAPTER_CACHE"

            INDEX=-1
            for id in "${!indexed_chapters[@]}"; do
                if [[ "${indexed_chapters[$id]}" == "$chapter_chosen" ]]; then
                    INDEX=$id
                fi
            done
            next_chapter="${indexed_chapters[$((INDEX + 1))]}"
            next_chapter_line="${chapters[$next_chapter]:-$num_lines}"

            ~/p/m/t/new-problem.sh "$problem_num" "$next_chapter_line"
        fi
    else
        echo "No parameter provided. Exiting."
    fi
    ;;
*)
    echo "No valid option selected. Exiting."
    ;;
esac
