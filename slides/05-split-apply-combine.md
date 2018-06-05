_[Link to Slides](http://www.porganized.com/Scripting-Course/slides/05-split-apply-combine.html)_


<center>Scripting for Large Databases</center>
![XKCD 353, about Python](https://imgs.xkcd.com/comics/python.png)


```python
%matplotlib inline
import pandas as pd
```

## Announcements

## Today

- Debugging
- Input / Output
- More Pandas Skills
- Split-Apply-Combine in Pandas with `groupby`
- Working with Databases

Ending with easier skills this week!

## Review

![](https://imgs.xkcd.com/comics/exploits_of_a_mom.png)


```python
# This loads and plots the data
mpg = pd.read_csv('http://vincentarelbundock.github.io/Rdatasets/csv/ggplot2/mpg.csv', index_col=0)
mpg.groupby('cyl')[['cty', 'hwy']].mean().plot()
```




    <matplotlib.axes._subplots.AxesSubplot at 0x2cbf9e7b860>




![png](output_5_1.png)


## Debugging Tips

![XKCD comic about debugging](https://imgs.xkcd.com/comics/wisdom_of_the_ancients.png)

_What have you been learning about fixing broken code?_

General advice:
    
 - Inspect your variables (print them to the screen). Are they what you expect?
     - This is very easy to do in a notebook - make use of it!
 - Remove code.
     - If there are multiple steps, go through each one in order, seeing if the output is what you expect at each step.
     - You can 'comment out' a line of code in Python by preceding it with a `#`
 - If chaining, split up the code into multiple lines, setting each step to a variable and inspecting the variable.

 - Read the error!
     - Don't fear the error message, it's trying to communicate! What does it say at the bottom?
 - Google the problem.
     - Even better, Google the error message
 - Run your code often.
     - Another benefit of notebooks: you can keep checking what you do as you're writing it.
 - Paste in similar code and try to modify it to your problem.

## Check the Docs

Good citizens document their code, so you can see the documentation with `?`.

Great citizens include examples. Scroll to the bottom of Pandas documentation and there's often an 'Examples' section.


```python
?pd.DataFrame
```

## Question: Where do I go for reference?

- Documentation
  - [Pandas Docs](http://pandas.pydata.org/)
  - [Python Documentation](https://docs.python.org/3/)
- Google
- Tutorials
  - See how the skills are taught in other contexts. A search for "Intro to Pandas" is rich, because it is so broadly used

- [Stack Overflow](https://stackoverflow.com/)
  - A programming question and answer site.
  - Tip: search with `[pandas]` in the query - that will focus results on questions tagged as being about Pandas
    - Pro-tip: Search for a tag only (no other query terms) and sort results by 'votes' to find the questions that people have have most valuable about that language, concept or library. e.g. [[pandas]](https://stackoverflow.com/questions/tagged/pandas?sort=votes&pageSize=15)

## Pandas notes

Points of clarity and potential confusion.

Actions on a DataFrame do not change the variable (i.e. are not *in-place*). You need to set what you do to a new variable to save it.

![Lego box](../images/lego.jpg)


```python
df = pd.read_csv('../data/cat_data.tsv', sep='\t')
```


```python
df.head(2)
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
      <th>Sex</th>
      <th>Bwt</th>
      <th>Hwt</th>
      <th>bwt_in_grams</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>M</td>
      <td>2.0</td>
      <td>6.5</td>
      <td>2000.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>M</td>
      <td>2.0</td>
      <td>6.5</td>
      <td>2000.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.sort_values('Hwt', ascending=False).head(2)
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
      <th>Sex</th>
      <th>Bwt</th>
      <th>Hwt</th>
      <th>bwt_in_grams</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>96</th>
      <td>M</td>
      <td>3.9</td>
      <td>20.5</td>
      <td>3900.0</td>
    </tr>
    <tr>
      <th>87</th>
      <td>M</td>
      <td>3.5</td>
      <td>17.2</td>
      <td>3500.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.head(2)
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
      <th>Sex</th>
      <th>Bwt</th>
      <th>Hwt</th>
      <th>bwt_in_grams</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>M</td>
      <td>2.0</td>
      <td>6.5</td>
      <td>2000.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>M</td>
      <td>2.0</td>
      <td>6.5</td>
      <td>2000.0</td>
    </tr>
  </tbody>
</table>
</div>



The sorting was temporary and `df` is still in its original state.

To save the sort try 

`variable_name = df.sort_values('Bwt')`

**Is this allowed?**

```
df = df.sort_values('Bwt')
```

## Setting new columns

```python
df['new_column'] = a_series_of_values
```

e.g.


```python
df['bwt_in_grams'] = df['Bwt'] * 1000
df.head()
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
      <th>Sex</th>
      <th>Bwt</th>
      <th>Hwt</th>
      <th>bwt_in_grams</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>M</td>
      <td>2.0</td>
      <td>6.5</td>
      <td>2000.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>M</td>
      <td>2.0</td>
      <td>6.5</td>
      <td>2000.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>M</td>
      <td>2.1</td>
      <td>10.1</td>
      <td>2100.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>M</td>
      <td>2.2</td>
      <td>7.2</td>
      <td>2200.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>M</td>
      <td>2.2</td>
      <td>7.6</td>
      <td>2200.0</td>
    </tr>
  </tbody>
</table>
</div>



## Unique Combinations with `drop_duplicates()`

A DataFrame doesn't have `unique()` like a Series.

But you can get unique combinations of columns with `drop_duplicates()` on a selection of columns.


```python
len(df)
```




    97




```python
no_dupes1 = df.drop_duplicates()
len(no_dupes1)
```




    90




```python
sex_wt_unique = df[['Sex', 'Bwt']].drop_duplicates()
len(sex_wt_unique)
```




    20



![](../images/pandas-pitch.png)

## Working against facets - Group-by, Split Apply Combine, and Data Cubes

> An integrated group by engine for aggregating and transforming data sets


```python
cats = pd.read_csv('../data/cat_data.tsv', sep='\t')
cats.sample(3)
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
      <th>Sex</th>
      <th>Bwt</th>
      <th>Hwt</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>81</th>
      <td>M</td>
      <td>3.4</td>
      <td>12.8</td>
    </tr>
    <tr>
      <th>26</th>
      <td>M</td>
      <td>2.6</td>
      <td>8.3</td>
    </tr>
    <tr>
      <th>63</th>
      <td>M</td>
      <td>3.1</td>
      <td>12.1</td>
    </tr>
  </tbody>
</table>
</div>



#### Question

Using skills we've learned, how can we determine the average heart weight (`Hwt`) for cats with a body weight of 2.7?


```python

```

- select a subset of the full dataset, where `Bwt == 2.7`
- run `mean()` on the subset


```python
subset = cats[cats['Bwt'] == 2.7]
subset.sample(5)
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
      <th>Sex</th>
      <th>Bwt</th>
      <th>Hwt</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>38</th>
      <td>M</td>
      <td>2.7</td>
      <td>12.0</td>
    </tr>
    <tr>
      <th>39</th>
      <td>M</td>
      <td>2.7</td>
      <td>12.5</td>
    </tr>
    <tr>
      <th>35</th>
      <td>M</td>
      <td>2.7</td>
      <td>9.8</td>
    </tr>
    <tr>
      <th>37</th>
      <td>M</td>
      <td>2.7</td>
      <td>11.1</td>
    </tr>
    <tr>
      <th>36</th>
      <td>M</td>
      <td>2.7</td>
      <td>10.4</td>
    </tr>
  </tbody>
</table>
</div>




```python
subset['Hwt'].mean()
```




    10.222222222222221



#### Question

How might we get the average for each of these weights: 2.7, 2.8, 2.9?


```python

```

One possibility: a loop.

For each desired value,
 - select a subset of the full dataset, where `Bwt` is that value
 - Run `mean()` on the subset


```python
for weight in [2.7, 2.8, 2.9]:
    ... what next?
```


```python
for weight in [2.7, 2.8, 2.9]:
    subset = cats[cats['Bwt'] == weight]
    mean_heart = subset['Hwt'].mean()
    print(weight, mean_heart)
```

    2.7 10.222222222222221
    2.8 11.357142857142858
    2.9 10.64


### Question: How would we get the means for all unique body weights?

(Let's include a count of measurements, for good measure)


```python

```

One option: get all unique values, then loop through them.


```python
bweights = cats['Bwt'].unique()
bweights
```




    array([2. , 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 3. , 3.1, 3.2,
           3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9])




```python
for weight in bweights:
    subset = cats[cats['Bwt'] == weight]
    mean_heart = subset['Hwt'].mean()
    print(weight, mean_heart)
```

    2.0 6.5
    2.1 10.1
    2.2 8.775
    2.3 9.6
    2.4 8.3
    2.5 9.975000000000001
    2.6 9.466666666666667
    2.7 10.222222222222221
    2.8 11.357142857142858
    2.9 10.64
    3.0 11.88888888888889
    3.1 12.216666666666667
    3.2 12.649999999999999
    3.3 13.580000000000002
    3.4 12.599999999999998
    3.5 14.620000000000001
    3.6 13.725000000000001
    3.7 11.0
    3.8 15.8
    3.9 17.45


This is the `Split-Apply-Combine` pattern.

You `split` the dataset into subsets based on some column (or a number of columns), and `apply` any operation against those subsets, rather than the whole. When you `combine`, you stick it back together into a table.

### `Split` doesn't need to just be one type of column

Consider:
    
 - What is the average heart weight for each body weight and sex?
    
What do we split on?   

- Male cats that are 2.0
- Female cats that are 2.0
- Male cats that are 2.1
- Female cats that are 2.1

*and so on...*

*For every combination of Sex and Bwt*.

![](../images/example-split-apply-combine.png)

## `groupby`

Split-Apply-Combine functionality in Pandas runs as follows:


```python
cats.groupby('Bwt').mean()
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
      <th>Sex</th>
      <th>Hwt</th>
    </tr>
    <tr>
      <th>Bwt</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2.0</th>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>2.1</th>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2.2</th>
      <td>8</td>
      <td>8</td>
    </tr>
    <tr>
      <th>2.3</th>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2.4</th>
      <td>5</td>
      <td>5</td>
    </tr>
    <tr>
      <th>2.5</th>
      <td>8</td>
      <td>8</td>
    </tr>
    <tr>
      <th>2.6</th>
      <td>6</td>
      <td>6</td>
    </tr>
    <tr>
      <th>2.7</th>
      <td>9</td>
      <td>9</td>
    </tr>
    <tr>
      <th>2.8</th>
      <td>7</td>
      <td>7</td>
    </tr>
    <tr>
      <th>2.9</th>
      <td>5</td>
      <td>5</td>
    </tr>
    <tr>
      <th>3.0</th>
      <td>9</td>
      <td>9</td>
    </tr>
    <tr>
      <th>3.1</th>
      <td>6</td>
      <td>6</td>
    </tr>
    <tr>
      <th>3.2</th>
      <td>6</td>
      <td>6</td>
    </tr>
    <tr>
      <th>3.3</th>
      <td>5</td>
      <td>5</td>
    </tr>
    <tr>
      <th>3.4</th>
      <td>5</td>
      <td>5</td>
    </tr>
    <tr>
      <th>3.5</th>
      <td>5</td>
      <td>5</td>
    </tr>
    <tr>
      <th>3.6</th>
      <td>4</td>
      <td>4</td>
    </tr>
    <tr>
      <th>3.7</th>
      <td>1</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3.8</th>
      <td>2</td>
      <td>2</td>
    </tr>
    <tr>
      <th>3.9</th>
      <td>2</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>



`dataframe.groupby(column_or_listOfColumns).method()`

What kind of methods are available?

- Fundamentals: `mean`, `count`, `sum`, `median`
- Summary stats: `quantile`, `min`, `max`, `std`, `skew`, `var`, `describe`


```python
cats.groupby('Bwt').describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead tr th {
        text-align: left;
    }

    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th colspan="8" halign="left">Hwt</th>
    </tr>
    <tr>
      <th></th>
      <th>count</th>
      <th>mean</th>
      <th>std</th>
      <th>min</th>
      <th>25%</th>
      <th>50%</th>
      <th>75%</th>
      <th>max</th>
    </tr>
    <tr>
      <th>Bwt</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2.0</th>
      <td>2.0</td>
      <td>6.500000</td>
      <td>0.000000</td>
      <td>6.5</td>
      <td>6.500</td>
      <td>6.50</td>
      <td>6.500</td>
      <td>6.5</td>
    </tr>
    <tr>
      <th>2.1</th>
      <td>1.0</td>
      <td>10.100000</td>
      <td>NaN</td>
      <td>10.1</td>
      <td>10.100</td>
      <td>10.10</td>
      <td>10.100</td>
      <td>10.1</td>
    </tr>
    <tr>
      <th>2.2</th>
      <td>8.0</td>
      <td>8.775000</td>
      <td>1.187735</td>
      <td>7.2</td>
      <td>7.825</td>
      <td>8.80</td>
      <td>9.600</td>
      <td>10.7</td>
    </tr>
    <tr>
      <th>2.3</th>
      <td>1.0</td>
      <td>9.600000</td>
      <td>NaN</td>
      <td>9.6</td>
      <td>9.600</td>
      <td>9.60</td>
      <td>9.600</td>
      <td>9.6</td>
    </tr>
    <tr>
      <th>2.4</th>
      <td>5.0</td>
      <td>8.300000</td>
      <td>0.860233</td>
      <td>7.3</td>
      <td>7.900</td>
      <td>7.90</td>
      <td>9.100</td>
      <td>9.3</td>
    </tr>
    <tr>
      <th>2.5</th>
      <td>8.0</td>
      <td>9.975000</td>
      <td>1.901691</td>
      <td>7.9</td>
      <td>8.750</td>
      <td>9.05</td>
      <td>11.425</td>
      <td>12.7</td>
    </tr>
    <tr>
      <th>2.6</th>
      <td>6.0</td>
      <td>9.466667</td>
      <td>1.392360</td>
      <td>7.7</td>
      <td>8.575</td>
      <td>9.40</td>
      <td>10.225</td>
      <td>11.5</td>
    </tr>
    <tr>
      <th>2.7</th>
      <td>9.0</td>
      <td>10.222222</td>
      <td>1.437687</td>
      <td>8.0</td>
      <td>9.600</td>
      <td>9.80</td>
      <td>11.100</td>
      <td>12.5</td>
    </tr>
    <tr>
      <th>2.8</th>
      <td>7.0</td>
      <td>11.357143</td>
      <td>1.686077</td>
      <td>9.1</td>
      <td>10.100</td>
      <td>11.40</td>
      <td>12.650</td>
      <td>13.5</td>
    </tr>
    <tr>
      <th>2.9</th>
      <td>5.0</td>
      <td>10.640000</td>
      <td>0.950263</td>
      <td>9.4</td>
      <td>10.100</td>
      <td>10.60</td>
      <td>11.300</td>
      <td>11.8</td>
    </tr>
    <tr>
      <th>3.0</th>
      <td>9.0</td>
      <td>11.888889</td>
      <td>1.331770</td>
      <td>10.0</td>
      <td>10.600</td>
      <td>12.20</td>
      <td>12.700</td>
      <td>13.8</td>
    </tr>
    <tr>
      <th>3.1</th>
      <td>6.0</td>
      <td>12.216667</td>
      <td>1.478400</td>
      <td>9.9</td>
      <td>11.650</td>
      <td>12.30</td>
      <td>12.875</td>
      <td>14.3</td>
    </tr>
    <tr>
      <th>3.2</th>
      <td>6.0</td>
      <td>12.650000</td>
      <td>0.840833</td>
      <td>11.6</td>
      <td>12.000</td>
      <td>12.65</td>
      <td>13.375</td>
      <td>13.6</td>
    </tr>
    <tr>
      <th>3.3</th>
      <td>5.0</td>
      <td>13.580000</td>
      <td>1.742699</td>
      <td>11.5</td>
      <td>12.000</td>
      <td>14.10</td>
      <td>14.900</td>
      <td>15.4</td>
    </tr>
    <tr>
      <th>3.4</th>
      <td>5.0</td>
      <td>12.600000</td>
      <td>1.166190</td>
      <td>11.2</td>
      <td>12.200</td>
      <td>12.40</td>
      <td>12.800</td>
      <td>14.4</td>
    </tr>
    <tr>
      <th>3.5</th>
      <td>5.0</td>
      <td>14.620000</td>
      <td>2.251000</td>
      <td>11.7</td>
      <td>12.900</td>
      <td>15.60</td>
      <td>15.700</td>
      <td>17.2</td>
    </tr>
    <tr>
      <th>3.6</th>
      <td>4.0</td>
      <td>13.725000</td>
      <td>1.490805</td>
      <td>11.8</td>
      <td>12.925</td>
      <td>14.05</td>
      <td>14.850</td>
      <td>15.0</td>
    </tr>
    <tr>
      <th>3.7</th>
      <td>1.0</td>
      <td>11.000000</td>
      <td>NaN</td>
      <td>11.0</td>
      <td>11.000</td>
      <td>11.00</td>
      <td>11.000</td>
      <td>11.0</td>
    </tr>
    <tr>
      <th>3.8</th>
      <td>2.0</td>
      <td>15.800000</td>
      <td>1.414214</td>
      <td>14.8</td>
      <td>15.300</td>
      <td>15.80</td>
      <td>16.300</td>
      <td>16.8</td>
    </tr>
    <tr>
      <th>3.9</th>
      <td>2.0</td>
      <td>17.450000</td>
      <td>4.313351</td>
      <td>14.4</td>
      <td>15.925</td>
      <td>17.45</td>
      <td>18.975</td>
      <td>20.5</td>
    </tr>
  </tbody>
</table>
</div>



### New Dataset: Movie Ratings


```python
ratings = pd.read_csv('../data/movielens_small.csv')
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
      <th>9078</th>
      <td>602</td>
      <td>5.0</td>
      <td>Heavenly Creatures</td>
      <td>Crime</td>
      <td>842357664</td>
      <td>1994</td>
    </tr>
    <tr>
      <th>20677</th>
      <td>605</td>
      <td>3.0</td>
      <td>Lethal Weapon</td>
      <td>Action</td>
      <td>980196811</td>
      <td>1987</td>
    </tr>
    <tr>
      <th>17563</th>
      <td>585</td>
      <td>4.0</td>
      <td>Blues Brothers, The</td>
      <td>Action</td>
      <td>975363282</td>
      <td>1980</td>
    </tr>
    <tr>
      <th>43353</th>
      <td>536</td>
      <td>4.0</td>
      <td>Forget Paris</td>
      <td>Comedy</td>
      <td>829471720</td>
      <td>1995</td>
    </tr>
    <tr>
      <th>65535</th>
      <td>428</td>
      <td>4.5</td>
      <td>Up</td>
      <td>Adventure</td>
      <td>1304133577</td>
      <td>2009</td>
    </tr>
    <tr>
      <th>18274</th>
      <td>671</td>
      <td>4.0</td>
      <td>Stand by Me</td>
      <td>Adventure</td>
      <td>1064890570</td>
      <td>1986</td>
    </tr>
    <tr>
      <th>14841</th>
      <td>231</td>
      <td>4.0</td>
      <td>Vertigo</td>
      <td>Drama</td>
      <td>977005465</td>
      <td>1958</td>
    </tr>
    <tr>
      <th>88775</th>
      <td>187</td>
      <td>4.0</td>
      <td>She's All That</td>
      <td>Comedy</td>
      <td>1237164621</td>
      <td>1999</td>
    </tr>
    <tr>
      <th>52870</th>
      <td>34</td>
      <td>3.0</td>
      <td>RoboCop</td>
      <td>Action</td>
      <td>973747643</td>
      <td>1987</td>
    </tr>
    <tr>
      <th>36830</th>
      <td>212</td>
      <td>2.0</td>
      <td>Notebook, The</td>
      <td>Drama</td>
      <td>1218402835</td>
      <td>2004</td>
    </tr>
  </tbody>
</table>
</div>




```python
ratings.groupby('genres').mean()
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
      <th>timestamp</th>
      <th>year</th>
    </tr>
    <tr>
      <th>genres</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>(no genres listed)</th>
      <td>388.750000</td>
      <td>3.843750</td>
      <td>1.446346e+09</td>
      <td>2007.250000</td>
    </tr>
    <tr>
      <th>Action</th>
      <td>337.182215</td>
      <td>3.445613</td>
      <td>1.154797e+09</td>
      <td>1995.082754</td>
    </tr>
    <tr>
      <th>Adventure</th>
      <td>342.289304</td>
      <td>3.575126</td>
      <td>1.148656e+09</td>
      <td>1991.789203</td>
    </tr>
    <tr>
      <th>Animation</th>
      <td>343.281416</td>
      <td>3.601991</td>
      <td>1.141861e+09</td>
      <td>1984.234513</td>
    </tr>
    <tr>
      <th>Children</th>
      <td>355.534774</td>
      <td>3.300752</td>
      <td>1.079186e+09</td>
      <td>1985.053102</td>
    </tr>
    <tr>
      <th>Comedy</th>
      <td>356.320066</td>
      <td>3.471017</td>
      <td>1.112612e+09</td>
      <td>1991.924808</td>
    </tr>
    <tr>
      <th>Crime</th>
      <td>348.160878</td>
      <td>3.858596</td>
      <td>1.134659e+09</td>
      <td>1990.268275</td>
    </tr>
    <tr>
      <th>Documentary</th>
      <td>380.458457</td>
      <td>3.834941</td>
      <td>1.177426e+09</td>
      <td>1998.091246</td>
    </tr>
    <tr>
      <th>Drama</th>
      <td>349.603162</td>
      <td>3.675361</td>
      <td>1.109920e+09</td>
      <td>1990.143787</td>
    </tr>
    <tr>
      <th>Fantasy</th>
      <td>326.980198</td>
      <td>3.516502</td>
      <td>1.140463e+09</td>
      <td>1988.544554</td>
    </tr>
    <tr>
      <th>Film-Noir</th>
      <td>354.451807</td>
      <td>4.054217</td>
      <td>1.061703e+09</td>
      <td>1951.409639</td>
    </tr>
    <tr>
      <th>Horror</th>
      <td>331.806618</td>
      <td>3.169102</td>
      <td>1.127812e+09</td>
      <td>1986.969489</td>
    </tr>
    <tr>
      <th>Musical</th>
      <td>369.141463</td>
      <td>3.643902</td>
      <td>1.050864e+09</td>
      <td>1962.034146</td>
    </tr>
    <tr>
      <th>Mystery</th>
      <td>339.951731</td>
      <td>3.902413</td>
      <td>1.116632e+09</td>
      <td>1990.224554</td>
    </tr>
    <tr>
      <th>Romance</th>
      <td>380.191667</td>
      <td>3.233333</td>
      <td>1.124502e+09</td>
      <td>1994.816667</td>
    </tr>
    <tr>
      <th>Sci-Fi</th>
      <td>338.758454</td>
      <td>3.159420</td>
      <td>1.227906e+09</td>
      <td>2001.057971</td>
    </tr>
    <tr>
      <th>Thriller</th>
      <td>342.089888</td>
      <td>3.494382</td>
      <td>1.059348e+09</td>
      <td>1994.748596</td>
    </tr>
    <tr>
      <th>War</th>
      <td>401.153846</td>
      <td>3.884615</td>
      <td>1.013561e+09</td>
      <td>1964.230769</td>
    </tr>
    <tr>
      <th>Western</th>
      <td>368.355372</td>
      <td>3.611570</td>
      <td>1.130332e+09</td>
      <td>1984.140496</td>
    </tr>
  </tbody>
</table>
</div>



Hmm, we don't want means for timestamp, etc. Just rating.

Columns to operate on can be selected after `groupby()`, with square brackets:


```python
results = ratings.groupby('genres')[['rating']].mean()
results
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
      <th>rating</th>
    </tr>
    <tr>
      <th>genres</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>(no genres listed)</th>
      <td>3.843750</td>
    </tr>
    <tr>
      <th>Action</th>
      <td>3.445613</td>
    </tr>
    <tr>
      <th>Adventure</th>
      <td>3.575126</td>
    </tr>
    <tr>
      <th>Animation</th>
      <td>3.601991</td>
    </tr>
    <tr>
      <th>Children</th>
      <td>3.300752</td>
    </tr>
    <tr>
      <th>Comedy</th>
      <td>3.471017</td>
    </tr>
    <tr>
      <th>Crime</th>
      <td>3.858596</td>
    </tr>
    <tr>
      <th>Documentary</th>
      <td>3.834941</td>
    </tr>
    <tr>
      <th>Drama</th>
      <td>3.675361</td>
    </tr>
    <tr>
      <th>Fantasy</th>
      <td>3.516502</td>
    </tr>
    <tr>
      <th>Film-Noir</th>
      <td>4.054217</td>
    </tr>
    <tr>
      <th>Horror</th>
      <td>3.169102</td>
    </tr>
    <tr>
      <th>Musical</th>
      <td>3.643902</td>
    </tr>
    <tr>
      <th>Mystery</th>
      <td>3.902413</td>
    </tr>
    <tr>
      <th>Romance</th>
      <td>3.233333</td>
    </tr>
    <tr>
      <th>Sci-Fi</th>
      <td>3.159420</td>
    </tr>
    <tr>
      <th>Thriller</th>
      <td>3.494382</td>
    </tr>
    <tr>
      <th>War</th>
      <td>3.884615</td>
    </tr>
    <tr>
      <th>Western</th>
      <td>3.611570</td>
    </tr>
  </tbody>
</table>
</div>



The grouping column defaults to being the index, but it can be changed with `as_index=False`:


```python
by_genre = ratings.groupby('genres', as_index=False)[['rating']].mean()
by_genre.head()
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
      <th>genres</th>
      <th>rating</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>(no genres listed)</td>
      <td>3.843750</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Action</td>
      <td>3.445613</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Adventure</td>
      <td>3.575126</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Animation</td>
      <td>3.601991</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Children</td>
      <td>3.300752</td>
    </tr>
  </tbody>
</table>
</div>



1. What is the mean rating by year?
2. What are the best years for movies since 1990?


```python

```


```python
by_year = ratings.groupby('year', as_index=False)[['rating']].mean()
by_year.sample(5)
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
      <th>year</th>
      <th>rating</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>67</th>
      <td>1981</td>
      <td>3.758763</td>
    </tr>
    <tr>
      <th>69</th>
      <td>1983</td>
      <td>3.658284</td>
    </tr>
    <tr>
      <th>6</th>
      <td>1920</td>
      <td>3.700000</td>
    </tr>
    <tr>
      <th>70</th>
      <td>1984</td>
      <td>3.651486</td>
    </tr>
    <tr>
      <th>17</th>
      <td>1931</td>
      <td>4.040816</td>
    </tr>
  </tbody>
</table>
</div>




```python
since_1990 = by_year[by_year.year >= 1990]
since_1990.sort_values('rating', ascending=False).head()
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
      <th>year</th>
      <th>rating</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>77</th>
      <td>1991</td>
      <td>3.628265</td>
    </tr>
    <tr>
      <th>93</th>
      <td>2007</td>
      <td>3.548879</td>
    </tr>
    <tr>
      <th>96</th>
      <td>2010</td>
      <td>3.537995</td>
    </tr>
    <tr>
      <th>80</th>
      <td>1994</td>
      <td>3.537963</td>
    </tr>
    <tr>
      <th>79</th>
      <td>1993</td>
      <td>3.536664</td>
    </tr>
  </tbody>
</table>
</div>



You can select multiple columns


```python
by_genre = ratings.groupby('genres', as_index=False)[['rating', 'year']].mean()
by_genre.head()
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
      <th>genres</th>
      <th>rating</th>
      <th>year</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>(no genres listed)</td>
      <td>3.843750</td>
      <td>2007.250000</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Action</td>
      <td>3.445613</td>
      <td>1995.082754</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Adventure</td>
      <td>3.575126</td>
      <td>1991.789203</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Animation</td>
      <td>3.601991</td>
      <td>1984.234513</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Children</td>
      <td>3.300752</td>
      <td>1985.053102</td>
    </tr>
  </tbody>
</table>
</div>



## Question: Best movies in this small dataset.


```python

```


```python
mean_ratings = ratings.groupby('title', as_index=False)[['rating']].mean()
mean_ratings.sort_values('rating', ascending=False).head(10)
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
      <th>title</th>
      <th>rating</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>5577</th>
      <td>Northerners, The (De noorderlingen)</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>7689</th>
      <td>The Big Gay Musical</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>8354</th>
      <td>Voyeur (Abel)</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>7686</th>
      <td>The Beatles: Eight Days a Week - The Touring Y...</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>5464</th>
      <td>New Police Story (Xin jing cha gu shi)</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>8363</th>
      <td>Waiter (Ober)</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>4627</th>
      <td>Lizzie McGuire Movie, The</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>963</th>
      <td>Bite the Bullet</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>5490</th>
      <td>Night Flier</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>3598</th>
      <td>Holy Motors</td>
      <td>5.0</td>
    </tr>
  </tbody>
</table>
</div>



*What are the problems here?*


```python
mean_ratings[mean_ratings.title == 'Hamlet']
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
      <th>title</th>
      <th>rating</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>3361</th>
      <td>Hamlet</td>
      <td>4.133333</td>
    </tr>
  </tbody>
</table>
</div>




```python
unique_title_year = ratings[['title', 'year']].drop_duplicates()
unique_title_year[unique_title_year.title == 'Hamlet']
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
      <th>title</th>
      <th>year</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>37732</th>
      <td>Hamlet</td>
      <td>1996</td>
    </tr>
    <tr>
      <th>55118</th>
      <td>Hamlet</td>
      <td>2000</td>
    </tr>
    <tr>
      <th>74303</th>
      <td>Hamlet</td>
      <td>1948</td>
    </tr>
    <tr>
      <th>89479</th>
      <td>Hamlet</td>
      <td>1964</td>
    </tr>
    <tr>
      <th>93871</th>
      <td>Hamlet</td>
      <td>1990</td>
    </tr>
  </tbody>
</table>
</div>



Problem 1: Some *titles* confound multiple *movies*


```python
ratings[ratings.title == 'Lizzie McGuire Movie, The']
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
      <th>99487</th>
      <td>599</td>
      <td>5.0</td>
      <td>Lizzie McGuire Movie, The</td>
      <td>Children</td>
      <td>1344133745</td>
      <td>2003</td>
    </tr>
  </tbody>
</table>
</div>



Problem 2: Some movies only have 1 or 2 ratings

**Problem: Some *titles* confound multiple *movies***

### Grouping by multiple columns

Before, we provided a column name string to `groupby`:

```
ratings.groupby('title').mean()
```

We can provide a `list` of column names:

```
ratings.groupby(['title', 'year']).mean()
```


```python
mean_ratings2 = ratings.groupby(['title', 'year']).mean()
mean_ratings2.head()
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
      <th></th>
      <th>userId</th>
      <th>rating</th>
      <th>timestamp</th>
    </tr>
    <tr>
      <th>title</th>
      <th>year</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>"Great Performances" Cats</th>
      <th>1998</th>
      <td>382.000000</td>
      <td>1.750000</td>
      <td>1.272201e+09</td>
    </tr>
    <tr>
      <th>$9.99</th>
      <th>2008</th>
      <td>362.666667</td>
      <td>3.833333</td>
      <td>1.296821e+09</td>
    </tr>
    <tr>
      <th>'Hellboy': The Seeds of Creation</th>
      <th>2004</th>
      <td>134.000000</td>
      <td>2.000000</td>
      <td>1.361244e+09</td>
    </tr>
    <tr>
      <th>'Neath the Arizona Skies</th>
      <th>1934</th>
      <td>207.000000</td>
      <td>0.500000</td>
      <td>1.258440e+09</td>
    </tr>
    <tr>
      <th>'Round Midnight</th>
      <th>1986</th>
      <td>377.000000</td>
      <td>2.250000</td>
      <td>1.215959e+09</td>
    </tr>
  </tbody>
</table>
</div>




```python
mean_ratings2.head(2)
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
      <th></th>
      <th>userId</th>
      <th>rating</th>
      <th>timestamp</th>
    </tr>
    <tr>
      <th>title</th>
      <th>year</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>"Great Performances" Cats</th>
      <th>1998</th>
      <td>382.000000</td>
      <td>1.750000</td>
      <td>1.272201e+09</td>
    </tr>
    <tr>
      <th>$9.99</th>
      <th>2008</th>
      <td>362.666667</td>
      <td>3.833333</td>
      <td>1.296821e+09</td>
    </tr>
  </tbody>
</table>
</div>



Hey! This is something that Pandas brags about:

> Index objects enabling both simple axis indexing and multi-level / hierarchical axis indexing


```python
mean_ratings2.loc['Hamlet']
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
      <th>timestamp</th>
    </tr>
    <tr>
      <th>year</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1948</th>
      <td>267.833333</td>
      <td>4.416667</td>
      <td>9.930363e+08</td>
    </tr>
    <tr>
      <th>1964</th>
      <td>269.000000</td>
      <td>4.500000</td>
      <td>9.490285e+08</td>
    </tr>
    <tr>
      <th>1990</th>
      <td>446.200000</td>
      <td>3.900000</td>
      <td>1.020174e+09</td>
    </tr>
    <tr>
      <th>1996</th>
      <td>340.520000</td>
      <td>4.160000</td>
      <td>1.013226e+09</td>
    </tr>
    <tr>
      <th>2000</th>
      <td>215.000000</td>
      <td>3.857143</td>
      <td>1.043834e+09</td>
    </tr>
  </tbody>
</table>
</div>



**Problem: Some movies only have 1 or 2 ratings**

## Aggregate

`df.groupby(...).aggregate()` allows you to *apply* multiple operations.


```python
ratings.groupby(['title','year']).aggregate(['count', 'mean']).head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead tr th {
        text-align: left;
    }

    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th></th>
      <th colspan="2" halign="left">userId</th>
      <th colspan="2" halign="left">rating</th>
      <th colspan="2" halign="left">timestamp</th>
    </tr>
    <tr>
      <th></th>
      <th></th>
      <th>count</th>
      <th>mean</th>
      <th>count</th>
      <th>mean</th>
      <th>count</th>
      <th>mean</th>
    </tr>
    <tr>
      <th>title</th>
      <th>year</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>"Great Performances" Cats</th>
      <th>1998</th>
      <td>2</td>
      <td>382.000000</td>
      <td>2</td>
      <td>1.750000</td>
      <td>2</td>
      <td>1.272201e+09</td>
    </tr>
    <tr>
      <th>$9.99</th>
      <th>2008</th>
      <td>3</td>
      <td>362.666667</td>
      <td>3</td>
      <td>3.833333</td>
      <td>3</td>
      <td>1.296821e+09</td>
    </tr>
    <tr>
      <th>'Hellboy': The Seeds of Creation</th>
      <th>2004</th>
      <td>1</td>
      <td>134.000000</td>
      <td>1</td>
      <td>2.000000</td>
      <td>1</td>
      <td>1.361244e+09</td>
    </tr>
    <tr>
      <th>'Neath the Arizona Skies</th>
      <th>1934</th>
      <td>1</td>
      <td>207.000000</td>
      <td>1</td>
      <td>0.500000</td>
      <td>1</td>
      <td>1.258440e+09</td>
    </tr>
    <tr>
      <th>'Round Midnight</th>
      <th>1986</th>
      <td>2</td>
      <td>377.000000</td>
      <td>2</td>
      <td>2.250000</td>
      <td>2</td>
      <td>1.215959e+09</td>
    </tr>
  </tbody>
</table>
</div>




```python
ratings.groupby(['title','year'])[['rating']].aggregate(['count', 'mean']).head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead tr th {
        text-align: left;
    }

    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th></th>
      <th colspan="2" halign="left">rating</th>
    </tr>
    <tr>
      <th></th>
      <th></th>
      <th>count</th>
      <th>mean</th>
    </tr>
    <tr>
      <th>title</th>
      <th>year</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>"Great Performances" Cats</th>
      <th>1998</th>
      <td>2</td>
      <td>1.750000</td>
    </tr>
    <tr>
      <th>$9.99</th>
      <th>2008</th>
      <td>3</td>
      <td>3.833333</td>
    </tr>
    <tr>
      <th>'Hellboy': The Seeds of Creation</th>
      <th>2004</th>
      <td>1</td>
      <td>2.000000</td>
    </tr>
    <tr>
      <th>'Neath the Arizona Skies</th>
      <th>1934</th>
      <td>1</td>
      <td>0.500000</td>
    </tr>
    <tr>
      <th>'Round Midnight</th>
      <th>1986</th>
      <td>2</td>
      <td>2.250000</td>
    </tr>
  </tbody>
</table>
</div>



Single quote selection will remove the two-level column heading.


```python
ratings.groupby(['title','year'])['rating'].aggregate(['count', 'mean']).head()
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
      <th></th>
      <th>count</th>
      <th>mean</th>
    </tr>
    <tr>
      <th>title</th>
      <th>year</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>"Great Performances" Cats</th>
      <th>1998</th>
      <td>2</td>
      <td>1.750000</td>
    </tr>
    <tr>
      <th>$9.99</th>
      <th>2008</th>
      <td>3</td>
      <td>3.833333</td>
    </tr>
    <tr>
      <th>'Hellboy': The Seeds of Creation</th>
      <th>2004</th>
      <td>1</td>
      <td>2.000000</td>
    </tr>
    <tr>
      <th>'Neath the Arizona Skies</th>
      <th>1934</th>
      <td>1</td>
      <td>0.500000</td>
    </tr>
    <tr>
      <th>'Round Midnight</th>
      <th>1986</th>
      <td>2</td>
      <td>2.250000</td>
    </tr>
  </tbody>
</table>
</div>




```python

```


```python
by_film = ratings.groupby(['title','year'])['rating'].aggregate(['count', 'mean'])
filtered_films = by_film[by_film['count'] > 50]
filtered_films.sort_values('mean', ascending=False).head()
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
      <th></th>
      <th>count</th>
      <th>mean</th>
    </tr>
    <tr>
      <th>title</th>
      <th>year</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Godfather, The</th>
      <th>1972</th>
      <td>200</td>
      <td>4.487500</td>
    </tr>
    <tr>
      <th>Shawshank Redemption, The</th>
      <th>1994</th>
      <td>311</td>
      <td>4.487138</td>
    </tr>
    <tr>
      <th>Maltese Falcon, The</th>
      <th>1941</th>
      <td>62</td>
      <td>4.387097</td>
    </tr>
    <tr>
      <th>Godfather: Part II, The</th>
      <th>1974</th>
      <td>135</td>
      <td>4.385185</td>
    </tr>
    <tr>
      <th>Usual Suspects, The</th>
      <th>1995</th>
      <td>201</td>
      <td>4.370647</td>
    </tr>
  </tbody>
</table>
</div>




```python
filtered_films.sort_values('mean', ascending=True).head()
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
      <th></th>
      <th>count</th>
      <th>mean</th>
    </tr>
    <tr>
      <th>title</th>
      <th>year</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Congo</th>
      <th>1995</th>
      <td>63</td>
      <td>2.341270</td>
    </tr>
    <tr>
      <th>Coneheads</th>
      <th>1993</th>
      <td>55</td>
      <td>2.463636</td>
    </tr>
    <tr>
      <th>Cable Guy, The</th>
      <th>1996</th>
      <td>59</td>
      <td>2.550847</td>
    </tr>
    <tr>
      <th>Judge Dredd</th>
      <th>1995</th>
      <td>70</td>
      <td>2.564286</td>
    </tr>
    <tr>
      <th>Ace Ventura: When Nature Calls</th>
      <th>1995</th>
      <td>92</td>
      <td>2.597826</td>
    </tr>
  </tbody>
</table>
</div>



> Input/Output tools: loading tabular data from flat files (CSV, delimited, Excel 2003), and saving and loading pandas objects from the fast and efficient PyTables/HDF5 format.

- `read_csv`, `read_excel`, `read_json` (and `to_csv`, `to_excel`, and `to_json`)
- For the RMS folks: Import/Output with Stata, Import from SAS
- For us: `read_sql` and `to_sql`
- For really big data: HDF5, Feather, Parquet
- For ease: `read_clipboard`, `to_clipboard`

## Read From HTML

This will convert the tables on a webpage into DataFrames.


```python
all_tables = pd.read_html('https://en.wikipedia.org/wiki/List_of_highest-grossing_films', header=0)
first_table = all_tables[0]
first_table.head(10)
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
      <th>Rank</th>
      <th>Peak</th>
      <th>Title</th>
      <th>Worldwide gross</th>
      <th>Year</th>
      <th>Reference(s)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>1</td>
      <td>Avatar</td>
      <td>$2,787,965,087</td>
      <td>2009</td>
      <td>[# 1][# 2]</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>1</td>
      <td>Titanic</td>
      <td>$2,187,463,944</td>
      <td>1997</td>
      <td>[# 3][# 4]</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>3</td>
      <td>Star Wars: The Force Awakens</td>
      <td>$2,068,223,624</td>
      <td>2015</td>
      <td>[# 5][# 6]</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>3</td>
      <td>Jurassic World</td>
      <td>$1,671,713,208</td>
      <td>2015</td>
      <td>[# 7][# 8]</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>3</td>
      <td>The Avengers</td>
      <td>$1,518,812,988</td>
      <td>2012</td>
      <td>[# 9][# 10]</td>
    </tr>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>4</td>
      <td>Furious 7</td>
      <td>$1,516,045,911</td>
      <td>2015</td>
      <td>[# 11][# 12]</td>
    </tr>
    <tr>
      <th>6</th>
      <td>7</td>
      <td>5</td>
      <td>Avengers: Age of Ultron</td>
      <td>$1,405,403,694</td>
      <td>2015</td>
      <td>[# 13][# 12]</td>
    </tr>
    <tr>
      <th>7</th>
      <td>8</td>
      <td>3</td>
      <td>Harry Potter and the Deathly Hallows – Part 2</td>
      <td>$1,341,511,219</td>
      <td>2011</td>
      <td>[# 14][# 15]</td>
    </tr>
    <tr>
      <th>8</th>
      <td>9</td>
      <td>9</td>
      <td>Star Wars: The Last Jedi</td>
      <td>$1,332,757,449</td>
      <td>2017</td>
      <td>[# 16]</td>
    </tr>
    <tr>
      <th>9</th>
      <td>10</td>
      <td>10</td>
      <td>Black Panther</td>
      <td>$1,324,656,634</td>
      <td>2018</td>
      <td>[# 17]</td>
    </tr>
  </tbody>
</table>
</div>



Not all websites allow access from headless browsers.

## Export to CSV


```python
cats.to_csv('cats.csv')
```

# SQL to Pandas, Pandas to SQL

*Q*: What databases can I connect?

*A*: A lot.

- Officially supported: SQLite, Postgresql, MySQL, Oracle, MS-SQL, Firebird, Sybase
- Supported with extensions: IBM DB2, Redshift, ExaSolution, MonetDB, Snowflake, CrateDB
- In the 'attic' (not maintained): MS Access

Reading from a database requires two steps:

1. Connect to the database
2. Give pandas the connection

Connect to the database:

```python
from sqlalchemy import create_engine
engine = create_engine('dialect://user:pass@host:port/schema')
```

This only needs to be done once - do it at the top of your notebook and `engine` will keep pointing to the database unless you close the session or rewrite the variable.

Give Pandas the connection:

```
result = pd.read_sql('SELECT * FROM table', engine)
```

```
engine = create_engine('dialect://user:pass@host:port/schema')
```

For SQLite:
    
- dialect: `sqlite`
- user: None, pass: None, port: Default (don't specify)
- schema: point to a file or leave blank for a temporary database

e.g. 

- `sqlite:///`
- `sqlite:///your_file_name.db`

If you're using a different database outside of class:

- Postgres: `postgresql://scott:tiger@localhost:5432/mydatabase`
- MySQL: `mysql+mysqldb://scott:tiger@localhost/foo`
- Oracle: `oracle://scott:tiger@127.0.0.1:1521/sidname`
- MS SQL (Microsoft): `mssql+pyodbc://mydsn`

[Reference](https://pandas.pydata.org/pandas-docs/stable/io.html#engine-connection-examples)


```python
from sqlalchemy import create_engine
engine = create_engine('sqlite:///../data/circulation.sqlite')
result = pd.read_sql('SELECT * FROM circulation LIMIT 5', engine)
result
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
      <th>book_id</th>
      <th>patron_id</th>
      <th>checkout_time</th>
      <th>return_time</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1898</td>
      <td>862</td>
      <td>2017-05-11 16:53:33.000000</td>
      <td>2017-06-09 16:40:11.804214</td>
    </tr>
    <tr>
      <th>1</th>
      <td>450</td>
      <td>215</td>
      <td>2018-01-05 13:07:20.000000</td>
      <td>2018-01-23 10:00:01.071255</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1840</td>
      <td>148</td>
      <td>2018-01-29 22:25:54.000000</td>
      <td>2018-03-03 05:15:48.780117</td>
    </tr>
    <tr>
      <th>3</th>
      <td>235</td>
      <td>58</td>
      <td>2017-06-21 07:27:02.000000</td>
      <td>2017-07-15 04:34:52.054251</td>
    </tr>
    <tr>
      <th>4</th>
      <td>522</td>
      <td>801</td>
      <td>2017-08-29 16:19:26.000000</td>
      <td>2017-09-29 18:25:42.337822</td>
    </tr>
  </tbody>
</table>
</div>



## Export to SQL


```python
tempdb = create_engine('sqlite:///')
```

Write a DataFrame to the table `Test` in the temporary database referenced by `tempdb`:


```python
result.to_sql('Test', tempdb)
```

Did it work? Call it up:


```python
pd.read_sql('SELECT * FROM Test LIMIT 1', tempdb)
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
      <th>index</th>
      <th>book_id</th>
      <th>patron_id</th>
      <th>checkout_time</th>
      <th>return_time</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>1898</td>
      <td>862</td>
      <td>2017-05-11 16:53:33.000000</td>
      <td>2017-06-09 16:40:11.804214</td>
    </tr>
  </tbody>
</table>
</div>



Anything look *odd*?


```python
pd.read_sql('SELECT * FROM Test LIMIT 1', tempdb, index_col='index')
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
      <th>book_id</th>
      <th>patron_id</th>
      <th>checkout_time</th>
      <th>return_time</th>
    </tr>
    <tr>
      <th>index</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1898</td>
      <td>862</td>
      <td>2017-05-11 16:53:33.000000</td>
      <td>2017-06-09 16:40:11.804214</td>
    </tr>
  </tbody>
</table>
</div>



You can't overwrite tables, unless you change the `if_exists` argument to 'replace' or 'append'

Will give an error the second time:

```python
result.to_sql('Test', tempdb)
```

No error:

```python
result.to_sql('Test', tempdb, if_exists='replace')
```

# Summary

- Changes to DataFrames need to be saved
- `drop_duplicates()` for unique combinations of columns
- `groupby()` provides Split-Apply-Combine functionality
  - can group by one column or multiple
  - aggregate allows you to apply multiple operations at once
- Work with databases using `read_sql` and `to_sql`
- Work with web data using `read_html`
