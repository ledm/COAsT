#!/bin/bash

# Install jupyter dep.
pip install jupyter
# Convert ipynb files to markdown.
jupyter nbconvert --to markdown ./example_scripts/notebooks/*.ipynb --output-dir ./example_scripts/notebooks/markdown/

# Loop through generated markdown files.
for FILE in ./example_scripts/notebooks/markdown/*.md; do 
    # Get filename information.
    fullname=$(basename $FILE)
    filename=${fullname%.*}
    formatted_filename=${filename//[_]/ }   # Strip out underscores.
    formatted_filename=${formatted_filename^}   # Capitalize.
    # Generate Hugo header for Markdown files.
    read -r -d '' VAR <<-EOM
---
    title: "$formatted_filename"
    linkTitle: "$formatted_filename"
    weight: 5

    description: >
        $formatted_filename example.
---
EOM
    # Echo hugo header to beginning of generated md file.
    echo "$VAR" | cat - $FILE > temp && mv temp $FILE
done