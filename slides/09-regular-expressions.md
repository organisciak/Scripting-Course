_[Link to Slides](http://www.porganized.com/Scripting-Course/slides/09-regular-expressions.html)_


# Regular Expressions

## Announcements

## Review

## Looking Back

*You're killing it!*

- SQL, Relational Databases
   - Selecting, sorting, limiting, joins
   - Using SQLite in Jupyter with `%sql`

- Data manipulation with Pandas
   - DataFrames and Series's
   - Import/Exporting to SQL
   - Pulling tables from web
   - Selection, sorting, counting

- Split-Apply-Combine
   - Groupby in Pandas

- Visualization

- Semi-Structured data in MongoDB
    - JSON
    - selection, sorting
    - Aggregations
    - MapReduce concepts

- String pattern matching and extraction with regular expressions

- Next week
    - Advanced Pandas (rolling, dates)
    - Web scraping

## Final Project Updates

## <center>Regular Expressions</center>
### <center>aka *regex*</center>

### Overview

Regular Expressions help you work with strings

*Pattern Matching*

e.g. Find all phone numbers on a web page

*Manipulation*

e.g. Match "{Lastname}, {Firstname}" in a set of records and rewrite it as "{Firstname} {Lastname}"

## Why?

- Checking whether an input is valid (i.e. password, phone number, email, etc.)
- Cleaning data
- More complex data subsetting
- Working with user inputs or other unstructured data

### Q: Where can you use regular expressions?

### A: Many, many places!

## In Python


```python
import re
comment = "It was a dark and stormy night."
```

Find a simple string:


```python
re.findall('dark', comment)
```




    ['dark']



Find all sequences of one or more word characters:


```python
re.findall('\w+', comment)
```




    ['It', 'was', 'a', 'dark', 'and', 'stormy', 'night']



## In SQL

SQLite doesn't support it, but...

**MySQL**

Select columns that match alphanumeric characters only:

```
SELECT * FROM table WHERE column REGEXP '^[A-Za-z0-9]+$';
```

**Postgresql**

Match strings that include foo, bar, or baz:

```
SELECT * FROM table WHERE value ~ 'foo|bar|baz';
```

## In Pandas


```python
import pandas as pd
movies = pd.read_csv('https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/movielens_small.csv')
movies.sample()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>userId</th>
      <th>rating</th>
      <th>title</th>
      <th>genres</th>
      <th>timestamp</th>
      <th>year</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>52455</th>
      <td>150</td>
      <td>2.5</td>
      <td>Deep Blue Sea</td>
      <td>Action</td>
      <td>1114308289</td>
      <td>1999</td>
    </tr>
  </tbody>
</table>
</div>



Find movies where there is a digit (`\d`) right before the end of the string (`$`):


```python
matches = movies.title.str.contains('\d$')
movies[matches].sample(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>userId</th>
      <th>rating</th>
      <th>title</th>
      <th>genres</th>
      <th>timestamp</th>
      <th>year</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>73693</th>
      <td>654</td>
      <td>4.0</td>
      <td>Predator 2</td>
      <td>Action</td>
      <td>1145393723</td>
      <td>1990</td>
    </tr>
    <tr>
      <th>97753</th>
      <td>452</td>
      <td>1.0</td>
      <td>Smokey and the Bandit III</td>
      <td>Action</td>
      <td>1016590031</td>
      <td>1983</td>
    </tr>
    <tr>
      <th>47841</th>
      <td>339</td>
      <td>3.5</td>
      <td>Die Hard 2</td>
      <td>Action</td>
      <td>1446663933</td>
      <td>1990</td>
    </tr>
    <tr>
      <th>77626</th>
      <td>467</td>
      <td>3.0</td>
      <td>54</td>
      <td>Drama</td>
      <td>939063634</td>
      <td>1998</td>
    </tr>
    <tr>
      <th>91148</th>
      <td>468</td>
      <td>2.5</td>
      <td>$9.99</td>
      <td>Animation</td>
      <td>1296189776</td>
      <td>2008</td>
    </tr>
    <tr>
      <th>41665</th>
      <td>165</td>
      <td>0.5</td>
      <td>Mission: Impossible II</td>
      <td>Action</td>
      <td>1111479113</td>
      <td>2000</td>
    </tr>
    <tr>
      <th>2108</th>
      <td>282</td>
      <td>4.5</td>
      <td>Apollo 13</td>
      <td>Adventure</td>
      <td>1111493750</td>
      <td>1995</td>
    </tr>
    <tr>
      <th>41352</th>
      <td>481</td>
      <td>3.0</td>
      <td>Harry Potter and the Deathly Hallows: Part 1</td>
      <td>Action</td>
      <td>1437003549</td>
      <td>2010</td>
    </tr>
    <tr>
      <th>20206</th>
      <td>550</td>
      <td>2.0</td>
      <td>Lethal Weapon 4</td>
      <td>Action</td>
      <td>943373045</td>
      <td>1998</td>
    </tr>
    <tr>
      <th>84657</th>
      <td>457</td>
      <td>2.5</td>
      <td>Friday the 13th Part 2</td>
      <td>Horror</td>
      <td>1471385314</td>
      <td>1981</td>
    </tr>
  </tbody>
</table>
</div>



Find movies where the substring ' Part ' exists:


```python
matches = movies.title.str.contains(' Part ')
movies[matches].sample(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>userId</th>
      <th>rating</th>
      <th>title</th>
      <th>genres</th>
      <th>timestamp</th>
      <th>year</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>41898</th>
      <td>150</td>
      <td>2.5</td>
      <td>Father of the Bride Part II</td>
      <td>Comedy</td>
      <td>1114308628</td>
      <td>1995</td>
    </tr>
    <tr>
      <th>41356</th>
      <td>570</td>
      <td>4.5</td>
      <td>Harry Potter and the Deathly Hallows: Part 1</td>
      <td>Action</td>
      <td>1475783785</td>
      <td>2010</td>
    </tr>
    <tr>
      <th>73544</th>
      <td>654</td>
      <td>5.0</td>
      <td>History of the World: Part I</td>
      <td>Comedy</td>
      <td>1145394077</td>
      <td>1981</td>
    </tr>
    <tr>
      <th>41937</th>
      <td>650</td>
      <td>3.0</td>
      <td>Father of the Bride Part II</td>
      <td>Comedy</td>
      <td>844883711</td>
      <td>1995</td>
    </tr>
    <tr>
      <th>25179</th>
      <td>494</td>
      <td>5.0</td>
      <td>Godfather: Part II, The</td>
      <td>Crime</td>
      <td>1342747453</td>
      <td>1974</td>
    </tr>
    <tr>
      <th>25123</th>
      <td>215</td>
      <td>4.0</td>
      <td>Godfather: Part II, The</td>
      <td>Crime</td>
      <td>860561181</td>
      <td>1974</td>
    </tr>
    <tr>
      <th>84670</th>
      <td>260</td>
      <td>3.0</td>
      <td>Friday the 13th Part VI: Jason Lives</td>
      <td>Horror</td>
      <td>1207886252</td>
      <td>1986</td>
    </tr>
    <tr>
      <th>50272</th>
      <td>232</td>
      <td>3.0</td>
      <td>Back to the Future Part III</td>
      <td>Adventure</td>
      <td>955086621</td>
      <td>1990</td>
    </tr>
    <tr>
      <th>50314</th>
      <td>518</td>
      <td>3.0</td>
      <td>Back to the Future Part III</td>
      <td>Adventure</td>
      <td>945364886</td>
      <td>1990</td>
    </tr>
    <tr>
      <th>71101</th>
      <td>564</td>
      <td>5.0</td>
      <td>Wes Craven's New Nightmare (Nightmare on Elm S...</td>
      <td>Drama</td>
      <td>974716031</td>
      <td>1994</td>
    </tr>
  </tbody>
</table>
</div>



Find movies that are named "The ... of ..."


```python
matches = movies.title.str.contains('^The .+ of ')
movies[matches].sample(10)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>userId</th>
      <th>rating</th>
      <th>title</th>
      <th>genres</th>
      <th>timestamp</th>
      <th>year</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>95699</th>
      <td>299</td>
      <td>4.5</td>
      <td>The Lair of the White Worm</td>
      <td>Comedy</td>
      <td>1344178630</td>
      <td>1988</td>
    </tr>
    <tr>
      <th>36099</th>
      <td>212</td>
      <td>4.0</td>
      <td>The Count of Monte Cristo</td>
      <td>Action</td>
      <td>1228789284</td>
      <td>2002</td>
    </tr>
    <tr>
      <th>68258</th>
      <td>624</td>
      <td>3.5</td>
      <td>The Theory of Everything</td>
      <td>Drama</td>
      <td>1449334366</td>
      <td>2014</td>
    </tr>
    <tr>
      <th>36111</th>
      <td>580</td>
      <td>2.5</td>
      <td>The Count of Monte Cristo</td>
      <td>Action</td>
      <td>1167160889</td>
      <td>2002</td>
    </tr>
    <tr>
      <th>36105</th>
      <td>386</td>
      <td>3.0</td>
      <td>The Count of Monte Cristo</td>
      <td>Action</td>
      <td>1047028511</td>
      <td>2002</td>
    </tr>
    <tr>
      <th>68254</th>
      <td>333</td>
      <td>4.0</td>
      <td>The Theory of Everything</td>
      <td>Drama</td>
      <td>1441197950</td>
      <td>2014</td>
    </tr>
    <tr>
      <th>36114</th>
      <td>607</td>
      <td>4.0</td>
      <td>The Count of Monte Cristo</td>
      <td>Action</td>
      <td>1151425776</td>
      <td>2002</td>
    </tr>
    <tr>
      <th>68256</th>
      <td>378</td>
      <td>3.5</td>
      <td>The Theory of Everything</td>
      <td>Drama</td>
      <td>1443292443</td>
      <td>2014</td>
    </tr>
    <tr>
      <th>68249</th>
      <td>73</td>
      <td>4.0</td>
      <td>The Theory of Everything</td>
      <td>Drama</td>
      <td>1457597352</td>
      <td>2014</td>
    </tr>
    <tr>
      <th>36104</th>
      <td>382</td>
      <td>2.5</td>
      <td>The Count of Monte Cristo</td>
      <td>Action</td>
      <td>1371825566</td>
      <td>2002</td>
    </tr>
  </tbody>
</table>
</div>



## In MongoDB


```python
from pymongo import MongoClient
client = MongoClient()
db = client.week7
collection = db.cooking
```

Find an recipe with an ingredient called "yellow ..."


```python
collection.find_one({
    "ingredients": {"$regex": "yellow .*"}
})
```




    {'_id': ObjectId('5af1b7634b6d022f8c977dd0'),
     'cuisine': 'southern_us',
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
      'vegetable oil']}



After unwinding the recipes to one doc per ingredient, find ingredients with a qualified salt:


```python
pipeline = [
    { "$unwind": "$ingredients" },
    { "$project": {"ingredients": 1, "_id":0} },
    { "$match":{
        "ingredients": {"$regex": "^.+ salt" }
        }
    },
    { "$limit": 5 }
]
results = collection.aggregate(pipeline)
list(results)
```




    [{'ingredients': 'sea salt'},
     {'ingredients': 'kosher salt'},
     {'ingredients': 'fine sea salt'},
     {'ingredients': 'kosher salt'},
     {'ingredients': 'kosher salt'}]



Count the qualified salt types:


```python
pipeline = [
    { "$unwind": "$ingredients" },
    { "$project": {"ingredients": 1, "_id":0} },
    { "$match":{ "ingredients": {"$regex": "^.+ salt$" } } },
    { "$group":{
        "_id": "$ingredients", "count": {"$sum": 1} } 
    },
    { "$sort": { "count": -1} },
    { "$limit": 20 }
]
results = collection.aggregate(pipeline)
list(results)
```




    [{'_id': 'kosher salt', 'count': 3113},
     {'_id': 'sea salt', 'count': 940},
     {'_id': 'coarse salt', 'count': 578},
     {'_id': 'fine sea salt', 'count': 285},
     {'_id': 'garlic salt', 'count': 240},
     {'_id': 'seasoning salt', 'count': 131},
     {'_id': 'table salt', 'count': 79},
     {'_id': 'coarse sea salt', 'count': 68},
     {'_id': 'coarse kosher salt', 'count': 64},
     {'_id': 'celery salt', 'count': 52},
     {'_id': 'fine salt', 'count': 24},
     {'_id': 'onion salt', 'count': 15},
     {'_id': 'rock salt', 'count': 14},
     {'_id': 'pickling salt', 'count': 12},
     {'_id': 'black salt', 'count': 12},
     {'_id': 'Himalayan salt', 'count': 11},
     {'_id': 'celtic salt', 'count': 9},
     {'_id': 'maldon sea salt', 'count': 8},
     {'_id': 'smoked sea salt', 'count': 6},
     {'_id': 'iodized salt', 'count': 4}]



### Note on variation

- Regular Expressions are *close* to standard, but different implementations are slightly different.

## Basics of Regular Expressions

In this class: we'll cover the basics, practiced in Python and Pandas.

To follow along:


```python
import re
```

## Wild Cards

`a` - Match the letter 'a'. Same for most other characters


```python
text = "Colorado"
re.findall('o', text)
```




    ['Colorado']




```python
text = "Buffalo buffalo Buffalo buffalo buffalo buffalo Buffalo buffalo"
re.findall('Buffalo buffalo', text)
```




    ['Buffalo buffalo', 'Buffalo buffalo', 'Buffalo buffalo']



`.` - Match any single character


```python
text = "who, what, where, why, and how"
re.findall('wh.', text)
```




    ['what']




```python
text = "who, what, where, why, and how"
re.findall('wh.,', text)
```




    ['who,', 'why,']



- `\w` - Match any word character (letters, number... support for non-English characters varies)
- `\W` - Match any non-word characters


```python
text = "Who, what, where, why, and how"
re.findall('\w\w\w,', text)
```




    ['Wh0,', 'hat,', 'ere,', 'why,']




```python
text = "Who, what, where, why, and how"
re.findall('\w', text)
```




    ['W',
     'h',
     'o',
     'w',
     'h',
     'a',
     't',
     'w',
     'h',
     'e',
     'r',
     'e',
     'w',
     'h',
     'y',
     'a',
     'n',
     'd',
     'h',
     'o',
     'w']



`\d` - Match any digit


```python
text = "Party like it's 1999"
re.findall('\d', text)
```




    ['1', '9', '9', '9']




```python
text = "Party like it's 1999"
re.findall('\d\d\d\d', text)
```




    ['1999']



`\s` - Match any whitespace character (space, tabs, line breaks sometimes)

*What will this return?*


```python
text = "The quick brown fox jumped over the lazy yellow dog"
re.findall('\s....\s', text)
```




    [' over ', ' lazy ']



`[ab]` - Group of multiple possible characters - in this case 'a' or 'b'


```python
text = "The quick brown fox jumped over the lazy yellow dog"
re.findall('[Tt]he', text)
```




    ['The', 'the']



### *What if I want to match an actual backslash or period?*

This is a problem:


```python
text = "Dr. Jones Drinks Too Much"
re.findall('Dr.', text)
```




    ['Dr.', 'Dri']



Precede the character with a backslash

E.g.

- `.` - Matches *any* character
- `\.` - Matches a period


```python
re.findall('Dr\.', text)
```




    ['Dr.']



- `[a-z]` matches any character from a to z
- `[A-Z]` matches any character from A to Z


```python
text = "text 1-800-SPAM for more information"
re.findall('[A-Z]+', text)
```




    ['SPAM']



Those square brackets are same as before, so you can group A-Z with other matches.

e.g. Match capital letters, digits, or hyphens:


```python
text = "text 1-800-SPAM for more information"
re.findall('[\d\-A-Z]+', text)
```




    ['1-800-SPAM']



*Note above that a hyphen is another special character, so matching for a literal `-` is done with `\-`.*

Returning to the earlier data.


```python
titles = movies.title.drop_duplicates()
```

"The (single word) of ..."


```python
matches = titles.str.contains('^The \w+ of ')
titles[matches].sample(10)
```




    99139                The End of the Tour
    94735          The Plague of the Zombies
    97198                     The Best of Me
    99821               The Face of an Angel
    88980       The Earrings of Madame de...
    68702               The Legend of Tarzan
    75357    The Importance of Being Earnest
    93216            The Diary of Anne Frank
    97199                   The Book of Life
    68479                 The Age of Adaline
    Name: title, dtype: object




```python
matches = titles.str.contains(':')
titles[matches].sample(10)
```




    67847                  Captain America: The Winter Soldier
    29299    Léon: The Professional (a.k.a. The Professiona...
    96755    Will Ferrell: You're Welcome America - A Final...
    88694         Nightmare on Elm Street 3: Dream Warriors, A
    82307                   Police Academy 6: City Under Siege
    92984                             Exorcist II: The Heretic
    75368                      Tabu: A Story of the South Seas
    94572                       Sherlock: The Abominable Bride
    93522       Librarian, The: The Curse of the Judas Chalice
    76784         City Slickers II: The Legend of Curly's Gold
    Name: title, dtype: object




```python
matches = titles.str.contains("^\w+\-\w+$")
titles[matches]
```




    259                  Ben-Hur
    12000             Spider-Man
    40269                  X-Men
    55032                  U-571
    58796             Scooby-Doo
    61252              Fail-Safe
    65729                G-Force
    66092               Kick-Ass
    68396                Ant-Man
    69332            Re-Animator
    69765    Slaughterhouse-Five
    81831                  K-PAX
    83228                 BURN-E
    83394               Non-Stop
    83908               Bio-Dome
    89557            Topsy-Turvy
    93256               Cry-Baby
    94106              She-Devil
    95079               Kon-Tiki
    96155              De-Lovely
    96602               Catch-22
    96617                Ben-hur
    96717               Semi-Pro
    98638                  T-Men
    99056     Shakespeare-Wallah
    99971        Straight-Jacket
    Name: title, dtype: object



## Exercises

Reference: 
    
- `a` - Match the letter 'a'. Same for most other characters
- `.` - Match any single character
- `\.` - Match a period. Same for other 'special' characters
- `\w` - Match any word character
- `\d` - Match any digit
- `\s` - Match any whitespace character
- `[ab]` - Group of multiple possible characters
- `[a-z]` matches any character from a to z
- `[A-Z]` matches any character from A to Z

## Repetition

`?` - One or zero of the preceding match


```python
text = "color colour"
re.findall('colour', text)
```




    ['colour']



- `+` - One or more of the preceding match
- `*` - Zero or more of the preceding match


```python
text = "GOAL GOOOOOOOOOAAAAAAL"
re.findall('GO+A+L', text)
```




    ['GOAL', 'GOOOOOOOOOAAAAAAL']




```python
text = "GOAL"
re.findall('GO+A+L', text)
```




    ['GOAL']



`*` and `+` are *greedy* in Python. They will grab as much as possible. 


```python
text = "<p>Something or other</p><p>Yet more junk.</p>" 
re.findall('<p>.*</p>', text)
```




    ['<p>Something or other</p><p>Yet more junk.</p>']




```python
text = "foo1@gmail.com;b-a-r@gmail.com;baz@gmail.com" 
re.findall('\w.*@gmail.com', text)
```




    ['foo1@gmail.com;b-a-r@gmail.com;baz@gmail.com']



`*?` is the *lazy* alternative, it will grab as little as possible.


```python

```




    ['foo1@gmail.com', 'b-a-r@gmail.com', 'baz@gmail.com']




```python
re.findall('\w.*?@gmail.com', text)
```




    ['foo1@gmail.com', 'b-a-r@gmail.com', 'baz@gmail.com']



## Start and End of Line

`^` - Start of line


```python
text = "The quick brown fox jumped over the lazy yellow dog"
re.findall('^quick', text)
```




    []




```python
re.findall('^The', text)
```




    ['The']




```python
re.findall('^.*fox', text)
```




    ['The quick brown fox']



`$` - End of line


```python
text = "The quick brown fox jumped over the lazy yellow dog"
re.findall('.......$', text)
```




    ['low dog']




```python
text = "The quick brown fox jumped over the lazy yellow dog"
re.findall("^.*$", text)
```




    ['The quick brown fox jumped over the lazy yellow dog']



## Reference

- `a` - Match the letter 'a'. Same for most other characters
- `.` - Match any single character
- `\.` - Match a period. Same for other 'special' characters
- `\w` - Match any word character
- `\d` - Match any digit
- `\s` - Match any whitespace character
- `[ab]` - Group of multiple possible characters
- `[a-z]` matches any character from a to z
- `[A-Z]` matches any character from A to Z
- `?` - One or zero of the preceding match
- `+` - One or more of the preceding match (greedy)
- `*` - Zero or more of the preceding match (greedy)
- `+?` - One or more of the preceding match (lazy)
- `*?` - Zero or more of the preceding match (lazy)
- `^` - Start of line
- `$` - End of line

# Additional tips

Choose a range for repetition with `{min,max}`. e.g.


```python
text = "YOLO"
re.search('YOLO{1,3}$', text) 
```




    <_sre.SRE_Match object; span=(0, 4), match='YOLO'>




```python
text = "YOLOOO"
re.search('YOLO{1,3}$', text)
```




    <_sre.SRE_Match object; span=(0, 6), match='YOLOOO'>




```python
text = "YOLOOOOOO"
re.search('YOLO{1,3}$', text)
```

*Negation*
    
Use the caret in square brackets: `[^aeiou]` means *not* a, e, t, o, or u

*Groups*
    
Use parentheses. e.g:


```python
text = "banana"
re.search('^ba(na)+$', text)
```




    <_sre.SRE_Match object; span=(0, 6), match='banana'>




```python
text = "lololololololololololol"
re.search('^l(ol)+$', text)
```




    <_sre.SRE_Match object; span=(0, 23), match='lololololololololololol'>



Capturing groups:


```python
text = "Ketchup Catsup"
re.findall('(Ketch|Cats)up', text)
```




    ['Ketch', 'Cats']


