#!/bin/bash

# Helper script to add a new blog post
# Usage: ./add-post.sh "Your Post Title" "Your,Tags,Here" "Brief description"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== AIComputing101 Blog Post Creator ===${NC}\n"

# Check if required arguments are provided
if [ $# -lt 3 ]; then
    echo -e "${YELLOW}Usage: $0 \"Post Title\" \"Tag1,Tag2\" \"Description\"${NC}"
    echo ""
    echo "Example:"
    echo "  $0 \"Advanced CUDA Programming\" \"GPU,Programming\" \"Learn advanced CUDA techniques\""
    exit 1
fi

TITLE="$1"
TAGS="$2"
DESCRIPTION="$3"

# Generate filename-safe ID from title
FILENAME=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
DATE=$(date +%Y%m%d)
FULL_FILENAME="${DATE}-${FILENAME}"

# Format date for display
DATE_DISPLAY=$(date +"%b %d, %Y")
DATE_ISO=$(date +%Y-%m-%d)

# Convert comma-separated tags to JSON array
IFS=',' read -ra TAG_ARRAY <<< "$TAGS"
TAG_JSON="["
for i in "${!TAG_ARRAY[@]}"; do
    if [ $i -gt 0 ]; then
        TAG_JSON+=", "
    fi
    TAG_JSON+="\"${TAG_ARRAY[$i]}\""
done
TAG_JSON+="]"

# Random image ID (1-200)
IMAGE_ID=$((RANDOM % 200))

echo -e "${GREEN}Creating new blog post:${NC}"
echo "  Title: $TITLE"
echo "  ID: $FULL_FILENAME"
echo "  Date: $DATE_DISPLAY"
echo "  Tags: $TAGS"
echo ""

# Create JSON entry
JSON_ENTRY=$(cat <<EOF
    {
      "id": "${FULL_FILENAME}",
      "title": "${TITLE}",
      "description": "${DESCRIPTION}",
      "date": "${DATE_ISO}",
      "dateDisplay": "${DATE_DISPLAY}",
      "tags": ${TAG_JSON},
      "image": "https://picsum.photos/id/${IMAGE_ID}/600/400",
      "url": "${FULL_FILENAME}.html"
    }
EOF
)

echo -e "${BLUE}JSON Entry (add this to posts.json):${NC}"
echo "$JSON_ENTRY"
echo ""

# Create a basic HTML template
# Detect if we're already in the blog directory
if [ "$(basename "$PWD")" = "blog" ]; then
    HTML_FILE="${FULL_FILENAME}.html"
else
    HTML_FILE="blog/${FULL_FILENAME}.html"
fi

if [ -f "$HTML_FILE" ]; then
    echo -e "${YELLOW}Warning: $HTML_FILE already exists. Skipping HTML creation.${NC}"
else
    cat > "$HTML_FILE" <<'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BLOG_TITLE - AIComputing101</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="font-inter bg-light text-dark antialiased">
    <!-- Add your blog post content here -->
    <article class="max-w-4xl mx-auto px-4 py-16">
        <h1 class="text-4xl font-bold mb-4">BLOG_TITLE</h1>
        <p class="text-gray-600 mb-8">BLOG_DATE</p>
        
        <div class="prose lg:prose-xl">
            <!-- Your content goes here -->
            <p>Write your blog post content here...</p>
        </div>
        
        <div class="mt-12">
            <a href="index.html" class="text-primary hover:underline">
                <i class="fa fa-arrow-left mr-2"></i> Back to Blog
            </a>
        </div>
    </article>
</body>
</html>
HTMLEOF

    # Replace placeholders
    sed -i '' "s/BLOG_TITLE/${TITLE}/g" "$HTML_FILE"
    sed -i '' "s/BLOG_DATE/${DATE_DISPLAY}/g" "$HTML_FILE"
    
    echo -e "${GREEN}✓ Created HTML template: $HTML_FILE${NC}"
fi

echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Copy the JSON entry above"
echo "2. Open blog/posts.json"
echo "3. Add the JSON entry to the 'posts' array (at the top is fine)"
echo "4. Edit $HTML_FILE with your content"
echo "5. Commit and push your changes"
echo ""
echo -e "${GREEN}Done!${NC}"
