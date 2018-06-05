_[Link to Notebook Version of Lab](https://github.com/organisciak/Scripting-Course/blob/master/labs/08-aggregations.ipynb)_


# Week 8 Lab: Aggregations

This week's questions are focused on aggregations in MongoDB. No other review: but keep practicing your SQL or Pandas in the context of your projects!

For references, here are the most notable *stages* of the pipeline:

- **\$match**: Select a subset of data (as you can do with 'find')
- **\$sort**: Order data by the values of a certain key
- **\$group**: Group data based on a key - like 'groupby' in Pandas
- **\$limit**: Trim the number of documents in the dataset
- **\$unwind**: Deconstruct an array, so that there is a document for every value of the array

## Dataset 1: Foursquare venues

Download [close_venues.json](https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/close_venues.json). This is a dataset of 50 venues near the University of Denver.

### Questions

- Create a database named `week8` and a collection named `foursquare`, then load `close_venues.json` into the collection. Share the code. There should be fifty documents.


```python
collection.count()
```




    50



- What's the venue with a cross-street of 'E Iliff Ave'? Paste the exact name string for auto-grading (e.g. if it says 'name': 'XYZ', enter *XYZ* as the answer)
- Which of these results has recieved the most 'tips'?
    - 'Daniels College of Business'
    - 'Nelson Hall Dining'
    - 'Anderson Academic Commons'
- Write an aggregation pipeline to answer the above question.
- How much do the following categories show up?
    - 'College Academic Building'
    - 'Bookstore'
    - 'College Library'
- Write an aggregation pipeline to answer the above question.
- What's the average distance for each of these categories, rounding down to the nearest whole number:
  - Bagel Shop
  - College Administrative Building
  - College Academic Building

## Dataset 2: Recommended Food in Denver

Load [popular_venues.json](Download [close_venues.json](https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/popular_venues.json). into a new collection. This is a dataset of 50 recommended food venues in Denver.


```python
collection.count()
```




    50



- In this dataset of popular food places, which of the following categories is best represented?
    - 'Breakfast Spot'
    - 'Sushi Restaurant'
    - 'Burger Joint'
- Which restaurant has the highest rating? Paste the exact 'name' string.
- Which restaurant has the most categories? Paste the name string.
  - Write the aggregation pipeline to get the above answer.
- Which restaurant has the most tips in this dataset? (Folding tipCounts from restaurants with multiple locations).
- Which 'tip' has the most likes?
    - "Get the Cricket Burger..."
    - "Voted Best Overall Wine List..."
    - "The Cinco Burger combines the best of..."
- What's the Male/Female gender split among users providing tips?
    - 50/50
    - 33/66
    - 66/33
- Write the code to determine which category of restaurant has the fewest average checkins, focusing only on categories with 3 or more restaurants in this dataset. Tip: the answer to the question is 'Café', with an average of 1258.7 checkins, followed by 'Pizza Place'.
