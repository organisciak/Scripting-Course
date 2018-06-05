_[Link to Notebook Version of Lab](https://github.com/organisciak/Scripting-Course/blob/master/labs/07-mongodb-json-lab.ipynb)_


Today's lab is a half-lab, combined with last week's short (but tricky!) lab.

## DataFrame Selection

This is here just for reference. Don't forget it!

**Selecting rows by numeric index**

Provide `x:y` notation in : `df[10:14]`

**Selecting rows by index name**

Provide the name to `.loc[]`: `df.loc['Sherlock Holmes']`

**Selecting rows by inclusion criteria**

Provide any collection (e.g. a list or Series) of True/False values:

```
df[[True, False, False, True, True]]
```

```
df[df.year > 1996]
```
    
**Selecting multiple columns**

Provide a collection of strings, referencing the column names:

```
df[['genres', 'year']]
```
    
**Selecting single column (as Series)**

```
df['year']
```

Or:

```
df.year
```

Consider the latter as the shortcut, not the main way.

The output is a Series. To select a single column as a DataFrame, use list with only one value.

## Opening JSON

Download [this file of recipe ingredients, from *Yummly*](https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/cooking.json) and save it to the save folder. 

Try opening the file in a text editor. What does it look like?


```python
import json
with open('cooking.json') as f:
    data = json.load(f)
```

What's done here? `with open(...) as f` syntax opens a file, setting it to a variable named `f`. That can read the raw text from the file, but the `json.load` function parses the text (one big string!) to a Python object.

This particular data is a big list of foods: try printing the first few items:


```python
data[:3]
```




    [{'cuisine': 'greek',
      'id': 10259,
      'ingredients': ['romaine lettuce',
       'black olives',
       'grape tomatoes',
       'garlic',
       'pepper',
       'purple onion',
       'seasoning',
       'garbanzo beans',
       'feta cheese crumbles']},
     {'cuisine': 'southern_us',
      'id': 25693,
      'ingredients': ['plain flour',
       'ground pepper',
       'salt',
       'tomatoes',
       'ground black pepper',
       'thyme',
       'eggs',
       'green tomatoes',
       'yellow corn meal',
       'milk',
       'vegetable oil']},
     {'cuisine': 'filipino',
      'id': 20130,
      'ingredients': ['eggs',
       'pepper',
       'salt',
       'mayonaise',
       'cooking oil',
       'green chilies',
       'grilled chicken breasts',
       'garlic powder',
       'yellow onion',
       'soy sauce',
       'butter',
       'chicken livers']}]



### Questions

- What type of cuisine is the 300th item (index=299) in the dataset?
- What food is the tenth ingredient of the 200th item in the data? Tip: you can count by hand for the answer, but see if you can grab it with code.
- If you had run `data2 = f.read()` instead of `data = json.load(f)`, what would the `data2` variable look like?
- What's the difference between running `print(data2[300:500])`, and having the notebook auto-print by running a cell with `data2[300:500]` on the last line?

## Installing MongoDB

MongoDB wasn't included when you installed Anaconda, so you'll have to run the command to install it.

**Open a command line interface to Anaconda**

- Windows: Open 'Command Prompt' from the Start Menu and type: `activate`.
- Mac OS/Linux: Open 'Terminal' from Applications and type `source activate`.

**Install Mongo Database and Python Library**

- Type the following command and press Enter/Return: `conda install -y mongodb pymongo`

**Start the Database**

MongoDB needs a running database to connect to. This is like most Database Management Systems, except the very lightweight SQLite.

- Start the database on the same command line by running the following code: `mongod`
- Keep this window open in the background for as long as you need access to the database. To close the program, press 'Ctrl+C' (use Ctrl even in Mac OS)

## Using MongoDB

In Python, you need to connect to the MongoDB server. Since you're running it on your own computer, the location is localhost and the port is 27017, as you can see referenced in the window where you started it:

![Mongo Port]('../images/mongod-port.png')

To connect, use the following code, where `week7` can be replaced with whatever database name you'd like:


```python
from pymongo import MongoClient
client = MongoClient('localhost', 27017)
db = client.week7
db
```




    Database(MongoClient(host=['localhost:27017'], document_class=dict, tz_aware=False, connect=True), 'week7')



### Connecting to a Collection

Here, I connect to the 'cooking' collection of `db`. If it doesn't exist, it will be created:


```python
collection = db.cooking
```

### Inserting Data

Lets insert our `data` from before. It's a list - data[0] is one 'document', data[1] is another one, and so on - so we can use `insert_many`:


```python
collection.insert_many(data)
```




    <pymongo.results.InsertManyResult at 0x1ea2ee6ea68>



It's also possible to use `insert_one` for a single record:

```collection.insert_one(your_record)```

# Questions

- How many documents are in the cooking collection?
   - 7954
   - 39774
   - 79548
- Match the cuisine to the number of documents that are that type of cuisine. Tip: You can run `count()` on the result of `find()`.
   - Cuisines: 'japanese', 'mexican', 'italian'
   - Counts: 6438, 7838, 1423
- How many results have liver as an ingredient? Tip: If you want to inspect the results to doublecheck but worry about printing a BFD (a 'big dataset'), you can add `limit(number_of_results)` to the result of `find()` before printing it. Just remember to remove it when you're counting, else you'll ony count the number that you selected!

`$in` and `$all` questions:

- How many results have both 'duck' and 'chinese five-spice powder'?
- How many results have either 'duck' or 'chinese five-spice powder'?
