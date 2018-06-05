_[Link to Notebook Version of Lab](https://github.com/organisciak/Scripting-Course/blob/master/labs/05-split-apply-combine-lab.ipynb)_


## Lab 5: Split Apply Combine


```python
import pandas as pd
```

### Movie Dataset Questions


```python
ratings = pd.read_csv('https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/movielens_small.csv')
ratings.sample(10)
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
      <th>78612</th>
      <td>195</td>
      <td>5.0</td>
      <td>Mister Roberts</td>
      <td>Comedy</td>
      <td>976287996</td>
      <td>1955</td>
    </tr>
    <tr>
      <th>13753</th>
      <td>122</td>
      <td>1.0</td>
      <td>True Lies</td>
      <td>Action</td>
      <td>832772925</td>
      <td>1994</td>
    </tr>
    <tr>
      <th>54447</th>
      <td>615</td>
      <td>4.5</td>
      <td>Modern Times</td>
      <td>Comedy</td>
      <td>1454913954</td>
      <td>1936</td>
    </tr>
    <tr>
      <th>99917</th>
      <td>652</td>
      <td>4.0</td>
      <td>Boy Culture</td>
      <td>Drama</td>
      <td>1439587482</td>
      <td>2006</td>
    </tr>
    <tr>
      <th>85120</th>
      <td>308</td>
      <td>5.0</td>
      <td>Murder in the First</td>
      <td>Drama</td>
      <td>854376623</td>
      <td>1995</td>
    </tr>
    <tr>
      <th>49824</th>
      <td>186</td>
      <td>5.0</td>
      <td>Pi</td>
      <td>Drama</td>
      <td>1295459249</td>
      <td>1998</td>
    </tr>
    <tr>
      <th>47311</th>
      <td>232</td>
      <td>5.0</td>
      <td>Unforgiven</td>
      <td>Drama</td>
      <td>955086527</td>
      <td>1992</td>
    </tr>
    <tr>
      <th>52215</th>
      <td>15</td>
      <td>1.0</td>
      <td>Muppets From Space</td>
      <td>Children</td>
      <td>1033344878</td>
      <td>1999</td>
    </tr>
    <tr>
      <th>91003</th>
      <td>452</td>
      <td>3.5</td>
      <td>Riding in Cars with Boys</td>
      <td>Comedy</td>
      <td>1077114749</td>
      <td>2001</td>
    </tr>
    <tr>
      <th>78433</th>
      <td>407</td>
      <td>4.0</td>
      <td>Mumford</td>
      <td>Comedy</td>
      <td>962648123</td>
      <td>1999</td>
    </tr>
  </tbody>
</table>
</div>



** Questions **

- Write the code to determine the median rating by each user.
- Using groupby, write the code to count how many ratings there are in each genre.
- The previous question can be answered without `groupby`. How?
    - a) `ratings.genres.unique()`
    - b) `ratings['genres'].value_counts()`
    - c) `ratings[['genres']].value_counts()`
    - d) `ratings[['genres']].unique()`
- Which genre has the worst average ratings?
    - a) Horror
    - b) Film-Noir
    - c) Mystery
    - d) Sci-Fi
- Select the three most out-of-vogue film genres, by median release year:
    - Crime
    - Documentary
    - Film-Noir
    - Musical
    - Children
    - Adventure
    - War
- Which film since 2011 has the most deviation among ratings?
    - The Heat
    - Twilight Saga: Breaking Dawn
    - The Secret Life of Pets
    - Drinking Buddies
- Get all the unique combinations of title+year. Submit the code.
- Run `ratings['movie']`. What does the error mean?
- What does the error message mean for the following code:
`ratings['new_column'] = ratings[ratings.genres == 'Drama']` ?
- Find all titles that refer to multiple movies released in different years. Share your code.

## Input / Output

- For the movie data: write the code to save a CSV of year/title/mean_rating.

- Write the code to open our book circulation database from two weeks ago, and retrieve information on patrons that are at least 18 years old as a DataFrame.

- For patrons over 18 years old, what is the most common city?
    - Thomasmouth
    - New Hannah
    - Michelefurt
- Write the code to determine the author with the most books checked out. Tip: remember joins!
- Write the code to retrieve the list of songs recorded by the Beatles from Wikipedia.

## Is In

Not all selection is done with logical operators. One useful method for a `Series` is `isin()`.

`isin()` takes a list or collection of values, and returns True/False for whether each item in the Series is in that set of values. Remember that DataFrame columns are Series'.

Example: Find movies where the genre is one of the following: Drama, Action, Sci-Fi.


```python
sample = ratings.sample(10)
sample
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
      <th>72782</th>
      <td>280</td>
      <td>4.0</td>
      <td>Mulan</td>
      <td>Adventure</td>
      <td>905582830</td>
      <td>1998</td>
    </tr>
    <tr>
      <th>99444</th>
      <td>584</td>
      <td>4.0</td>
      <td>Valentine's Day</td>
      <td>Comedy</td>
      <td>1276156202</td>
      <td>2010</td>
    </tr>
    <tr>
      <th>55100</th>
      <td>509</td>
      <td>2.0</td>
      <td>Big Kahuna, The</td>
      <td>Comedy</td>
      <td>978758257</td>
      <td>2000</td>
    </tr>
    <tr>
      <th>93192</th>
      <td>405</td>
      <td>4.0</td>
      <td>K-19: The Widowmaker</td>
      <td>Action</td>
      <td>1061359235</td>
      <td>2002</td>
    </tr>
    <tr>
      <th>47452</th>
      <td>492</td>
      <td>4.0</td>
      <td>Raise the Red Lantern (Da hong deng long gao g...</td>
      <td>Drama</td>
      <td>898110583</td>
      <td>1991</td>
    </tr>
    <tr>
      <th>22388</th>
      <td>105</td>
      <td>4.0</td>
      <td>Dead Ringers</td>
      <td>Drama</td>
      <td>1085640284</td>
      <td>1988</td>
    </tr>
    <tr>
      <th>48494</th>
      <td>247</td>
      <td>3.0</td>
      <td>Speed 2: Cruise Control</td>
      <td>Action</td>
      <td>953272853</td>
      <td>1997</td>
    </tr>
    <tr>
      <th>23101</th>
      <td>148</td>
      <td>4.5</td>
      <td>Big</td>
      <td>Comedy</td>
      <td>1059504963</td>
      <td>1988</td>
    </tr>
    <tr>
      <th>12073</th>
      <td>353</td>
      <td>3.5</td>
      <td>Spider-Man</td>
      <td>Action</td>
      <td>1112270265</td>
      <td>2002</td>
    </tr>
    <tr>
      <th>93981</th>
      <td>452</td>
      <td>3.0</td>
      <td>Ghosts of Mississippi</td>
      <td>Drama</td>
      <td>976426457</td>
      <td>1996</td>
    </tr>
  </tbody>
</table>
</div>




```python
sample.genres.isin(['Action', 'Drama', 'Sci-Fi'])
```




    72782    False
    99444    False
    55100    False
    93192     True
    47452     True
    22388     True
    48494     True
    23101    False
    12073     True
    93981     True
    Name: genres, dtype: bool




```python
sample[sample.genres.isin(['Action', 'Drama', 'Sci-Fi'])]
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
      <th>79663</th>
      <td>529</td>
      <td>4.0</td>
      <td>Coming Home</td>
      <td>Drama</td>
      <td>959964947</td>
      <td>1978</td>
    </tr>
    <tr>
      <th>58755</th>
      <td>379</td>
      <td>3.5</td>
      <td>Bourne Identity, The</td>
      <td>Action</td>
      <td>1378180358</td>
      <td>2002</td>
    </tr>
    <tr>
      <th>63046</th>
      <td>388</td>
      <td>3.5</td>
      <td>Da Vinci Code, The</td>
      <td>Drama</td>
      <td>1167703367</td>
      <td>2006</td>
    </tr>
    <tr>
      <th>43869</th>
      <td>157</td>
      <td>2.5</td>
      <td>Hot Shots! Part Deux</td>
      <td>Action</td>
      <td>1292452011</td>
      <td>1993</td>
    </tr>
    <tr>
      <th>93611</th>
      <td>624</td>
      <td>2.0</td>
      <td>Colombiana</td>
      <td>Action</td>
      <td>1350761819</td>
      <td>2011</td>
    </tr>
    <tr>
      <th>75285</th>
      <td>350</td>
      <td>5.0</td>
      <td>No Man's Land</td>
      <td>Drama</td>
      <td>1026761849</td>
      <td>2001</td>
    </tr>
    <tr>
      <th>69780</th>
      <td>355</td>
      <td>2.5</td>
      <td>Village, The</td>
      <td>Drama</td>
      <td>1130107001</td>
      <td>2004</td>
    </tr>
  </tbody>
</table>
</div>



*Question*

Practice using `isin()` yourself, then try the following bigger question:
    
- Write the code to select all ratings by the 10 most prolific users.

Tip:

Step by step, consider what you need to do. At the end, you'll want

`ratings[ratings.userId.isin(top_users)]`

So the question is: how do you get the list of user ids that make up the `top_users` variable? `top_users` can be a series.
