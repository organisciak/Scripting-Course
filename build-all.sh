ls | grep -P "^slides-.*md$" | parallel ./build.sh {.}
# Munge everything into one big doc
ls | grep -P "^\d.*md$" | parallel -n 1 "cat {}; echo '-----'" >reference.md
