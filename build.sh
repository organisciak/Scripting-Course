name=$1
slideurl=http\\://www.porganized.com/Scripting-Course
docurl=https\\://github.com/organisciak/Scripting-Course/blob/master/
# TWO LEVEL
#pandoc --slide-level 2 -s -t revealjs -V theme=white -V transition=fade -V slideNumber=true -V history=true --mathjax $name.md -o $name.html
# ONE LEVEL
pandoc --slide-level 1 -s -t revealjs -V theme=white-custom -V transition=fade -V slideNumber=true -V history=true --mathjax $name.md -o $name.html
# Renew TOC
ls *md | perl -pe "s:^(slides)-(.*)\.md:(@) \2\n\t+ [Slides]($slideurl/\1-\2.html) \([Docs]($docurl/\1-\2.md)\):g" | pandoc -f markdown -t html -o index.html
