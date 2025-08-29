pandoc 0*_*.md \
    -o out/example.pdf \
    --from markdown --template eisvogel --pdf-engine=xelatex \
    --listings