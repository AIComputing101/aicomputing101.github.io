# Blog Management Guide

## Overview
The AIComputing101 blog now uses a dynamic, JSON-based system for managing posts. This makes it easy to add, update, or remove blog posts without manually editing HTML.

## Features
✅ **Automatic sorting by date** (newest first)  
✅ **Tag-based filtering** (dynamically generated)  
✅ **Real-time search** (titles, descriptions, tags)  
✅ **Post count display**  
✅ **Responsive design** maintained  
✅ **Fast client-side rendering**  

## How to Add a New Blog Post

### Step 1: Create Your Blog Post HTML
Create your blog post HTML file in the `blog/` directory with the naming convention:
```
YYYYMMDD-your-post-title.html
```

Example: `20251030-new-gpu-techniques.html`

### Step 2: Add Entry to posts.json
Open `blog/posts.json` and add your new post to the `posts` array. **Add it at the top** for easy management (the system will auto-sort by date anyway).

```json
{
  "id": "20251030-new-gpu-techniques",
  "title": "Advanced GPU Programming Techniques",
  "description": "A deep dive into modern GPU optimization strategies for AI workloads.",
  "date": "2025-10-30",
  "dateDisplay": "Oct 30, 2025",
  "tags": ["GPU", "Programming"],
  "image": "https://picsum.photos/id/170/600/400",
  "url": "20251030-new-gpu-techniques.html"
}
```

### Field Descriptions:
- **id**: Unique identifier (usually matches filename without .html)
- **title**: Post title (displayed in list and card)
- **description**: Brief summary (1-2 sentences)
- **date**: ISO format date (YYYY-MM-DD) - used for sorting
- **dateDisplay**: Human-readable date format
- **tags**: Array of category tags (used for filtering)
- **image**: Featured image URL (can use placeholder or your own)
- **url**: Filename of the blog post

### Step 3: Commit and Push
```bash
git add blog/posts.json blog/20251030-new-gpu-techniques.html
git commit -m "Add new blog post: Advanced GPU Programming Techniques"
git push
```

That's it! The blog index will automatically:
- Sort your post by date
- Add your tags to the filter buttons
- Make it searchable
- Display it with the correct styling

## Managing Existing Posts

### Update a Post
Edit the entry in `posts.json`:
```json
{
  "id": "20251026-how-to-contribute-triton",
  "title": "Updated Title Here",
  "description": "Updated description...",
  ...
}
```

### Remove a Post
Simply delete the entry from `posts.json` (and optionally delete the HTML file).

### Change Post Date
Update the `date` field - the list will automatically re-sort.

## Tag Management

Tags are automatically collected from all posts and displayed as filter buttons. To add a new tag category, simply use it in a post's `tags` array:

```json
"tags": ["New Category", "Existing Category"]
```

## Best Practices

1. **Consistent Date Format**: Always use `YYYY-MM-DD` for the `date` field
2. **Keep Descriptions Short**: 1-2 sentences work best (200-300 characters)
3. **Use Descriptive Tags**: Help readers find related content
4. **Image Aspect Ratio**: Use 3:2 ratio images (600x400) for best results
5. **Test Locally**: Open `blog/index.html` in a browser before pushing

## Placeholder Images

The current setup uses [Picsum Photos](https://picsum.photos/) for placeholder images:
- Format: `https://picsum.photos/id/{ID}/600/400`
- Replace {ID} with a number (0-1000+)
- Or use your own hosted images

## Troubleshooting

### Posts not showing up?
1. Check `posts.json` syntax with a JSON validator
2. Ensure `date` field is in correct format
3. Check browser console for errors (F12)

### Search not working?
1. Clear browser cache
2. Check that `searchInput` element exists in HTML

### Tags not appearing?
1. Verify `tags` is an array in `posts.json`
2. Check browser console for JavaScript errors

## Future Enhancements

Potential improvements you could add:
- Pagination (show 10 posts at a time)
- RSS feed generation
- Reading time estimates
- Author information
- Related posts section
- Archive by month/year
- Featured posts
- Social sharing buttons

## Questions?

If you encounter issues or have suggestions, please open an issue on the GitHub repository.
