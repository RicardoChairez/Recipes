# Recipes
Take home test for Fetch apprenticeship

# PLEASE READ
I built this take home test on top of the previous take home I completed for Fetch a few months ago so there is some code that is recycled.

Also please understand that I put a lot of time and effort into these take home tests and I understand that I might not be selected for next round interviews, but I would really deeply appreciate it if I could get some kind of feedback.

Thank you


### Summary: Include screen shots or a video of your app highlighting its features

Simple 2 screen app. One screen displays a list of recipe previews and the other displays (what would be) the actual recipe.

![IMG_3602](https://github.com/user-attachments/assets/9e6d5e16-3383-4eef-bdfe-bba312daf363)
![IMG_3603](https://github.com/user-attachments/assets/93840b33-4d7f-4605-9fb7-f57fc02daca6)


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

The previous take home test I used the Kingfisher library to cache the images for me, but this version of the test I had to manually cache them. This is where most of my time spent went, as I had never manually cached data like this before. I was questioning where the images should be stored, and I ultimately came up with a solution that downloads the image data onto the RecipePreview model in the background. When the user refreshes, instead of downloading all the image data that comes in, I compare any duplicates between the new model coming in and the previous model and copy any image data where necessary. I am happy with my result, as it saves a ton on network usage. 

I found this to be a fun challenge and I actually like the solution I came up with more than depending on a library. 

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I started on Saturday and put about 2 hours in each day with having in completed on Monday. About 6 hours in total.  First day I worked exclusively on image caching. Second day I cleaned up some of the networking because I had previously had all of it inside of the view model and wanted to make a more "production-ready" and scalable solution. Third day I implemented unit tests and cleaned up some of the UI.

I am happy with how I allocated my time. Since the UI was mostly completed already, I got to focus on my new approach to image caching and optimizing my networking code.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

One thing you might notice is that I do not utilize the small images provided, despite having small image previews in the RecipesView. I felt the small images were of too low quality, even for the previews. I recognize that caching these larger images could be costly in the long run, however for this small app I do think it is worth it. Also, having cached the large images in RecipesView allows me to instantly display a larger photo in the RecipeView which is pretty nice.

Another decision I made I mentioned earlier with copying image data from previous models into the new model when refreshing. While this does save on network usage, it does add some strain on the CPU. Nothing significant or app-slowing, but it is something to think about. (N^2 to copy the images)

### Weakest Part of the Project: What do you think is the weakest part of your project?

Architecture. I understand I don't have the absolute cleanest most optimal way of writing code but I do think I generally have the right idea. I believe my implementation of MVVM was great, but lacking some optimizations that would make things more scalable and production-ready. This is where I think an iOS apprenticeship position at a reputable company with a quality app full of talented engineers would help me :^)

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
