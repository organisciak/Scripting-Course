_[Link to Notebook Version of Lab](https://github.com/organisciak/Scripting-Course/blob/master/labs/09-lab-regular-expressions.ipynb)_


# Lab 9: Regular Expressions


```python
import re
import pandas as pd
```

Here is a synopsis of the best film of our time, *Paddington*:


```python
synopsis = '''After a deadly earthquake destroys his home in Peruvian rainforest, a young bear (Ben Whishaw) makes his way to England in search of a new home. The bear, dubbed "Paddington" for the london train station, finds shelter with the family of Henry (Hugh Bonneville) and Mary Brown (Sally Hawkins). Although Paddington's amazement at urban living soon endears him to the Browns, someone else has her eye on him: Taxidermist Millicent Clyde (Nicole Kidman) has designs on the rare bear and his hide.'''
print(synopsis)
```

    After a deadly earthquake destroys his home in Peruvian rainforest, a young bear (Ben Whishaw) makes his way to England in search of a new home. The bear, dubbed "Paddington" for the london train station, finds shelter with the family of Henry (Hugh Bonneville) and Mary Brown (Sally Hawkins). Although Paddington's amazement at urban living soon endears him to the Browns, someone else has her eye on him: Taxidermist Millicent Clyde (Nicole Kidman) has designs on the rare bear and his hide.


For these questions, use `re.findall(pattern, text)`, like so:


```python
re.findall('[A-Z]....\s', synopsis)
```




    ['After ', 'Henry ', 'Brown ', 'Sally ', 'Clyde ']



## *About this week's lab*

The quiz submission is an ill-fit for evaluating these skills. For this lab,

- complete the questions in a copy of this notebook
- assign your answer to the variable in the cell that has `# Answer` written. Feel free to create new cells to work, but keep keep the answer cells.
- Before submitting, doublecheck that everything runs! Go to `Kernel > Restart and Run All` to confirm.
- submit the `ipynb` file in Canvas.

### Example Question

- Q0.0: Write the regular expression to find all three or four-letter words:


```python
# My personal workspace
re.findall('\s\w\w\w\w?\s', synopsis)
```




    [' his ',
     ' bear ',
     ' his ',
     ' new ',
     ' The ',
     ' for ',
     ' with ',
     ' and ',
     ' soon ',
     ' him ',
     ' the ',
     ' else ',
     ' her ',
     ' has ',
     ' the ',
     ' bear ',
     ' his ']




```python
# Answer
answer00_pattern = '\s\w\w\w\w?\s'
```

## Questions #1: Matching Characters (20 pts)

- Q1.1: Write a regular expression to match all three-character words surrounded by spaces. (5pts)


```python
# Answer
answer11_pattern = 
```

- Q1.2: Write a regular expression to match all three-character words, allowing for instances like `(Ben` and `him:`.  (5pts)


```python
# Answer
answer12_pattern = 
```

- Q1.3: How many times does the word `the` show up?  (5pts)


```python
# Answer
answer13_number = 
```

- Q1.4: Write a regular expression to find the context at the end of a sentence: the five characters leading up to the period and space. Results should be `[' home.', 'kins).', ' hide.']`  (5pts)


```python
# Answer
answer14_pattern = 
```

## Questions #2: Repeating Patterns (36 pts)

- Q2.1: Write the expression that creates the following matches: `['. The', '. Although']` (6 pts)


```python
# Answer
answer21_pattern = 
```

- Q2.2: Write the expression to match the two words following the word `a`. The results should be `['a deadly earthquake', 'a young bear', 'a new home']` (6 pts)


```python
# Answer
answer22_pattern = 
```

- Q2.3: Write the expression to match all words with an `'s`. In this case, `Paddington's` is the only match.  (6 pts)


```python
# Answer
answer23_pattern = 
```

- Q2.4: Write the expression to match all values in parentheses. The results should be `['(Ben Whishaw)', '(Hugh Bonneville)', '(Sally Hawkins)', '(Nicole Kidman)]'` (6 pts)


```python
# Answer
answer24_pattern = 
```

- Q2.5: Write the expression to match all capitalized words, including `Paddington's`. (6 pts)


```python
# Answer
answer25_pattern = 
```

- Q2.6: Write the expression to match all pairings of capitalized words, like `Mary Brown` and `Although Paddington`. (6 pts)


```python
# Answer
answer26_pattern = 
```

## Other Python Regular Expression Functions

**Replace a pattern**:
    
```
re.sub(pattern, repl, string)
```

This replaces the pattern matches with whatever string you provide to `repl`.

**Check a match**:
    
```
regex.search(string)
```

This doesn't return anything if there are no matches, so it's useful for asking, "is there a match or not?"

## Pandas

Load the following data into a DataFrame, containing the tweets of Lord_Voldemort7:


```python
tweets = pd.read_csv('https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/voldemort_tweets.csv')
tweets.head()
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
      <th>id</th>
      <th>favourites</th>
      <th>retweets</th>
      <th>created_at</th>
      <th>text</th>
      <th>is_quoted</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>903664289411686400</td>
      <td>1921</td>
      <td>556</td>
      <td>2017-09-01 17:02:10</td>
      <td>#19YearsLater #BackToHogwarts</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>901217559860703234</td>
      <td>2556</td>
      <td>934</td>
      <td>2017-08-25 22:59:44</td>
      <td>"I rose up from the dead, I do it all the time" @taylorswift13 #snakes https://t.co/Y4mQousLeq</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>879505014422740994</td>
      <td>3879</td>
      <td>1578</td>
      <td>2017-06-27 01:01:50</td>
      <td>#HarryPotter20 There will always be magic.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3</th>
      <td>818293342622650368</td>
      <td>737</td>
      <td>169</td>
      <td>2017-01-09 03:08:30</td>
      <td>Hermione tries to play Quidditch but hits her head, accidentally transfigures the furniture &amp;amp; goes to the Yule Ball? https://t.co/V5J9cY9aNu</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>815434344357625856</td>
      <td>2719</td>
      <td>1012</td>
      <td>2017-01-01 05:47:52</td>
      <td>2016 was channeling The Little Mermaid and ended the year by stealing Mariah Carey's voice.</td>
      <td>False</td>
    </tr>
  </tbody>
</table>
</div>



String actions on a DataFrame column (that is, a Series) are accessed with:

```
df['columnName'].str
```

For matching on regular expressions, you can use `.str.contains()`. For examples:


```python
matches = tweets.text.str.contains('dead')
tweets[matches]
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
      <th>id</th>
      <th>favourites</th>
      <th>retweets</th>
      <th>created_at</th>
      <th>text</th>
      <th>is_quoted</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>901217559860703234</td>
      <td>2556</td>
      <td>934</td>
      <td>2017-08-25 22:59:44</td>
      <td>"I rose up from the dead, I do it all the time" @taylorswift13 #snakes https://t.co/Y4mQousLeq</td>
      <td>False</td>
    </tr>
    <tr>
      <th>158</th>
      <td>485447695797342208</td>
      <td>2452</td>
      <td>1860</td>
      <td>2014-07-05 15:38:44</td>
      <td>You thought they were fireworks, America, but really another tribute is dead.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>476</th>
      <td>356617010102276096</td>
      <td>949</td>
      <td>1221</td>
      <td>2013-07-15 03:31:35</td>
      <td>'Harry Potter' is the #1 Worldwide Trending Topic. In other news, Sparkly Cedric is still dead.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>549</th>
      <td>331832894916026369</td>
      <td>440</td>
      <td>802</td>
      <td>2013-05-07 18:08:21</td>
      <td>If looks could kill then my body would be a deady weapon.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>576</th>
      <td>325320048459784192</td>
      <td>280</td>
      <td>506</td>
      <td>2013-04-19 18:48:38</td>
      <td>Perhaps news outlets/reporters/blogs should stop referring to Boston as a 'ghost town' and saying the 'streets are dead'. #ThinkTHENtalk</td>
      <td>False</td>
    </tr>
    <tr>
      <th>630</th>
      <td>318112066038812672</td>
      <td>2675</td>
      <td>5703</td>
      <td>2013-03-30 21:26:41</td>
      <td>'Happy Easter' is a TT. So when I rise from the apparent dead everyone gets alllll upset but when Jesus does it it's a holiday? #Muggles</td>
      <td>False</td>
    </tr>
    <tr>
      <th>706</th>
      <td>303184749021757440</td>
      <td>1577</td>
      <td>3621</td>
      <td>2013-02-17 16:50:51</td>
      <td>Yo mum is so ugly that when a basilisk looked her in the eyes, IT dropped dead.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>721</th>
      <td>300324033327661056</td>
      <td>1592</td>
      <td>3431</td>
      <td>2013-02-09 19:23:23</td>
      <td>#ThingsYouShouldntDo: Tell Harry Potter that you are 'dead sirius'.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>762</th>
      <td>290634984979574784</td>
      <td>2880</td>
      <td>6569</td>
      <td>2013-01-14 01:42:34</td>
      <td>When you wish upon a star you are actually a few million years late. That star is dead. Just like your dreams.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>997</th>
      <td>254647981960212481</td>
      <td>1326</td>
      <td>4293</td>
      <td>2012-10-06 18:23:04</td>
      <td>#HarryPotterPickupLines Did you survive the Avada Kedavra curse? Because you're drop dead gorgeous.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1473</th>
      <td>201347612161482752</td>
      <td>529</td>
      <td>1179</td>
      <td>2012-05-12 16:26:26</td>
      <td>"Happy Mother's Day" is trending. My mother is dead. Way to bring THAT up again, twitter.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1633</th>
      <td>188777643741679616</td>
      <td>1817</td>
      <td>8036</td>
      <td>2012-04-07 23:57:52</td>
      <td>Happy Easter is trending. So when I rise from the apparent dead everyone gets alllll upset but when Jesus does it it's a holiday? #Muggles</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1713</th>
      <td>182230301756489728</td>
      <td>1516</td>
      <td>7857</td>
      <td>2012-03-20 22:21:04</td>
      <td>#ReplacePotterQuoteWithBacon: "Do not pity the dead, Harry. Pity the living, and, above all, those who live without bacon."</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1752</th>
      <td>173926527266861056</td>
      <td>134</td>
      <td>546</td>
      <td>2012-02-27 00:24:50</td>
      <td>I am disappointed there is a "dead body" on the red carpet and it is not that of Sirius Black. #OldmanfortheOscar</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1846</th>
      <td>160917485812584448</td>
      <td>289</td>
      <td>1693</td>
      <td>2012-01-22 02:51:32</td>
      <td>First sources said Joe Paterno was dead. Now they say he's not. Rising from the grave? Who does he think he is, the Dark Lord?</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1851</th>
      <td>160441582955405312</td>
      <td>323</td>
      <td>2357</td>
      <td>2012-01-20 19:20:28</td>
      <td>SOPA is dead. Technology rising above to beat people &amp; make them submit. Wow, this should be a movie plot or something.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2063</th>
      <td>142430282883145728</td>
      <td>531</td>
      <td>2588</td>
      <td>2011-12-02 02:30:00</td>
      <td>#Confusingthingsthatgirlsdo: vampires. Um, they're dead... no blood flow. Can someone explain to me how THAT works?</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2107</th>
      <td>139497416234778624</td>
      <td>312</td>
      <td>2002</td>
      <td>2011-11-24 00:15:50</td>
      <td>Happy Thanksgiving is trending. When celebrating, remember that gluttony is one of the seven deadly sins. Only six more to go. Keep it up!</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2172</th>
      <td>133699908418019328</td>
      <td>322</td>
      <td>884</td>
      <td>2011-11-08 00:18:36</td>
      <td>"Over my dead body" is trending... http://t.co/ucAe8qxj</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2280</th>
      <td>126995230770728960</td>
      <td>423</td>
      <td>3760</td>
      <td>2011-10-20 12:16:37</td>
      <td>#Gadhafi might be dead according to the US. He MIGHT be, he also might be hiding in the forests of Albania biding his time....</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2342</th>
      <td>123182153663123456</td>
      <td>193</td>
      <td>1311</td>
      <td>2011-10-09 23:44:48</td>
      <td>That moment when Helena Bonham Carter is trending and you panic that means she's dead. #BellatrixLives</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2485</th>
      <td>114302574429077504</td>
      <td>668</td>
      <td>4207</td>
      <td>2011-09-15 11:40:32</td>
      <td>Vampires VS Zombies? I pick neither.What is the point of a matchup in which both sides have already failed &amp; ended up dead?</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2520</th>
      <td>111932844573593600</td>
      <td>558</td>
      <td>2557</td>
      <td>2011-09-08 22:44:04</td>
      <td>#TheLastTimeIChecked having sex with a vampire is doing it with a dead person. Pretty sure that's illegal in both wizarding &amp; muggle worlds.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2731</th>
      <td>97853846096838656</td>
      <td>1512</td>
      <td>6110</td>
      <td>2011-08-01 02:19:09</td>
      <td>I do not fear death. I fear coming back from the dead as a sparkly vampire.</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2802</th>
      <td>92391844780060672</td>
      <td>557</td>
      <td>3272</td>
      <td>2011-07-17 00:35:07</td>
      <td>#youwereonmygoodside because if you were on my bad side you'd be dead...</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2950</th>
      <td>81047386037825536</td>
      <td>695</td>
      <td>4297</td>
      <td>2011-06-15 17:16:17</td>
      <td>#funeralhomeslogans "We're dead serious about our business."</td>
      <td>False</td>
    </tr>
    <tr>
      <th>3000</th>
      <td>77486937857994752</td>
      <td>703</td>
      <td>4562</td>
      <td>2011-06-05 21:28:20</td>
      <td>#thingsthatmakenosense The Breaking Dawn Trailer. So she's getting knocked up by a dead guy &amp; the werewolf falls in love with a toddler..?</td>
      <td>False</td>
    </tr>
  </tbody>
</table>
</div>



*Tip*: The tweet text will be cutoff by default when print. You can change the width of columns to show the entire tweet with the following code:


```python
pd.set_option("display.max_colwidth", 160)
```

## Questions 3 (24pts)

*Unless otherwise specified, return all columns when asked to return tweets; e.g. don't remove the id or retweets columns.*

- Q3.1 How many tweets mention "Harry Potter"? You can get the number of rows by putting your resulting dataframe inside `len(df)`. (6 pts)


```python
# Answer
answer_31_number = 
```

- Q3.2 Return the tweets that have a hashtag (assuming only word characters in hashtags). There should be 1432 rows. (6 pts)


```python
# Answer
answer_32_df = 
```

- Q3.3 Return the tweets that have at least *two* hashtags (assuming only word characters in hashtags). There should be 190 rows. (8 pts)


```python
# Answer
answer_33_df = 
```

- Q3.4 Return the tweets that mention a year in the current millenium (or something that looks like one). (6 pts)


```python
# Answer
answer_34_df = 
```




    (190, 6)



## Some more Pandas string methods

Counting matches in a column:

```
df['columnName'].str.count(pat)
```

Replacing a pattern with a string:

```
df['columnName'].str.replace(pat, repl)
```

## Questions 4: Other string methods and non-regex Pandas practice (20 pts)

- Q4.1 Return the 20 tweets with the most favourites. (5 pts)


```python
# Answer
answer_41_df = 
```

- Q4.2 How many total favourites do this account's first 100 tweets have? (5 pts)


```python
# Answer
answer_42_number = 
```

- Q4.3 What is the id of the tweet matching the following criteria: has the lowest retweet-to-favourites ratio, among tweets without hashtags (10pts)


```python
# Answer
answer_43_id = 
```
