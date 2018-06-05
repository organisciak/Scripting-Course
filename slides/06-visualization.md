_[Link to Slides](http://www.porganized.com/Scripting-Course/slides/06-visualization.html)_


## <center>Scripting Week 6</center>
# <center>Visualization</center>


```python
%matplotlib inline
import pandas as pd
```

## Today

- Visualization
- Wide vs. Long - reshaping
- Collecting Data
- Joins in Pandas
- More Practice!

## Final Project Ideas

# Review

# Characterizing Data

What do we need to know about our data before visualizing it?

- Number of dimensions
- Type of data
    - Discrete vs. Continuous
    - Dependent and Independent variables
    - Relationships: nominal, ordinal, numeric

## Discrete vs. Continous

*Discrete* variables are countable, and exist on a identifiable, finite scale.

- How many plants do you have?
- What was the result of a coin flip?

*Continous* variables exist in an infinite scale.

- How much does a cat weight?
- At what time was a book checked out?

Think of your range of realistic values: can you only select specific values within that range, or can you feasibly select any value?

- *How many books are checked out?*
- *What was the temperature yesterday?*

* You can group by discrete variables. Grouping by continous variables would be pointless.

### Precision

* Much data is discrete but sampled from a continous distribution. This can be treated as continous data.

e.g. Age saved by year, even though you *could* have infinite precision.

## Types of Discrete Variables

*Nominal* or *categorical*: Can be counted but not ordered.

- e.g. Country GDP (is there a natural order between China, Lichtenstein, and US?)

*Ordinal*: Can be counted and ordered.
    
- e.g. Online product ratings

*Numerical* or *interval*: Ordered, with a meaningful relationship/distance between values.

- e.g. Counts or frequencies

## Independent vs. Dependent

- Independent: The variable that is controlled in an experiment
    - e.g. 'age', 'gender'
    - e.g. 'diet' in a study of healthy eating
- Dependent: The variable that is measured or changes
    - e.g. 'blood pressure', 'weight' in a study of healthy eating

Outside of experimental design, you don't always know what's dependent or independent.

## Number of Dimensions

How many different variables are you trying to visualize at once?

Examples:

- Univariate: Heights of a group of people
- 2-dimensional: What's the relationship between cyclinders in an engine and fuel economy?
- 3-dimensional: What's the relationship between cylinders in an engine and fuel economy, grouped by weight class?

## Size of the Data

How many data points do you have?

If not many: no need to visualize!

## Relationships

- Heirarchical: some measures have parent/child relationships.
    - e.g. folder size on your computer, book counts by call number
- Network relationships: links between data points.
    - e.g. social network data

## Exercises


```python
cats = pd.read_csv('https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/cat_data.tsv', sep='\t')
beer = pd.read_csv('https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/beers.csv')
movies = pd.read_csv('https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/movielens_small.csv')
imls = pd.read_csv('https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/imls_mini_by_state.csv')
mpg = pd.read_csv('http://vincentarelbundock.github.io/Rdatasets/csv/ggplot2/mpg.csv', index_col=0)
```


```python
cats.head()
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
      <th>0</th>
      <td>M</td>
      <td>2.0</td>
      <td>6.5</td>
    </tr>
    <tr>
      <th>1</th>
      <td>M</td>
      <td>2.0</td>
      <td>6.5</td>
    </tr>
    <tr>
      <th>2</th>
      <td>M</td>
      <td>2.1</td>
      <td>10.1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>M</td>
      <td>2.2</td>
      <td>7.2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>M</td>
      <td>2.2</td>
      <td>7.6</td>
    </tr>
  </tbody>
</table>
</div>



- Sex: Ordinal
- Bwt: Continuous
- Hwt: Continuous


```python
beer.head()
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
      <th>abv</th>
      <th>ibu</th>
      <th>id</th>
      <th>name</th>
      <th>type</th>
      <th>brewery_id</th>
      <th>ounces</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.050</td>
      <td>NaN</td>
      <td>1436</td>
      <td>Pub Beer</td>
      <td>American Pale Lager</td>
      <td>408</td>
      <td>12.0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.066</td>
      <td>NaN</td>
      <td>2265</td>
      <td>Devil's Cup</td>
      <td>American Pale Ale (APA)</td>
      <td>177</td>
      <td>12.0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.071</td>
      <td>NaN</td>
      <td>2264</td>
      <td>Rise of the Phoenix</td>
      <td>American IPA</td>
      <td>177</td>
      <td>12.0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.090</td>
      <td>NaN</td>
      <td>2263</td>
      <td>Sinister</td>
      <td>American Double / Imperial IPA</td>
      <td>177</td>
      <td>12.0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.075</td>
      <td>NaN</td>
      <td>2262</td>
      <td>Sex and Candy</td>
      <td>American IPA</td>
      <td>177</td>
      <td>12.0</td>
    </tr>
  </tbody>
</table>
</div>



- abv: continuous
- type: nominal
- ounces: continuous or interval


```python
movies.head()
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
      <th>0</th>
      <td>1</td>
      <td>2.5</td>
      <td>Dangerous Minds</td>
      <td>Drama</td>
      <td>1260759144</td>
      <td>1995</td>
    </tr>
    <tr>
      <th>1</th>
      <td>7</td>
      <td>3.0</td>
      <td>Dangerous Minds</td>
      <td>Drama</td>
      <td>851868750</td>
      <td>1995</td>
    </tr>
    <tr>
      <th>2</th>
      <td>31</td>
      <td>4.0</td>
      <td>Dangerous Minds</td>
      <td>Drama</td>
      <td>1273541953</td>
      <td>1995</td>
    </tr>
    <tr>
      <th>3</th>
      <td>32</td>
      <td>4.0</td>
      <td>Dangerous Minds</td>
      <td>Drama</td>
      <td>834828440</td>
      <td>1995</td>
    </tr>
    <tr>
      <th>4</th>
      <td>36</td>
      <td>3.0</td>
      <td>Dangerous Minds</td>
      <td>Drama</td>
      <td>847057202</td>
      <td>1995</td>
    </tr>
  </tbody>
</table>
</div>



- genres: nominal/categorical
- rating: ordinal (often treated as interval)
- timestamp: continuous
- year: continuous or interval


```python

```

# Visualization

Why visualize?

## Visualization in Pandas

Pandas uses a library called `matplotlib` under the hood - another part of the 'Scipy Stack'.

Basic line plot:

```
df.plot()
```

That's it!

Make plots show in a notebook, rather than saving to your computer.

For interactive plots:


```python
%matplotlib notebook
```

For non-interactive (image-only) plot:


```python
%matplotlib inline
```

*Run this once.*

**Feel free to experiment, but for now, use the non-interactive version. There are some surprises with interactive plots that we'll return to**


```python
# Changing default size (IGNORE -- this is for better slide presentation)
import matplotlib
# Default (6,4) at DPI 72
matplotlib.rcParams['figure.figsize'] = (6,4)
matplotlib.rcParams['figure.dpi'] = (150)
```


```python
cats.plot()
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1dde476c0b8>




![png](output_38_1.png)


*What's the y-axis? What's the x-axis?*

Hmmm... some problems:

- There's no continuous dependent variable for a line chart.
- It tries to plot *every* int or float column as a line.
- The 'index as x-axis' isn't insightful.

Explicitly setting an x and y plot:

```python
df.plot(x=..., y=...)
```

e.g.


```python
cats.plot(x='Bwt', y='Hwt')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1dde47d3e80>




![png](output_44_1.png)


## Setting the type of plot

Use the `kind` argument:


```python
cats.plot(x='Bwt', y='Hwt', kind='scatter')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1dde483de10>




![png](output_46_1.png)


# Kinds of Plots in Matplotlib

## *Bar Chart* and *Horizontal Bar Chart*

`kind='bar'`, `kind='barh'`

Good for categorical discrete data.

Dimensions: 2 axes. Color can be used for 3rd dimension.


```python
imls.head(20).plot(kind='bar', x='State', y='Revenue')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1dde55504e0>




![png](output_49_1.png)


*Does color mean anything here?*


```python
imls.head(20).plot(kind='bar', x='State', y='Revenue', color='blue')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1dde5573ef0>




![png](output_51_1.png)


FYI: Our 'easy' approach to visualization, through Pandas, can take color names or codes, but you can't easily color against a variable.

'barh' is just 'bar' rotated (literally - 'x' refers to the vertical axis).

Good for many categories: easier to read and - on screens - the height of an image can scale better than the width.


```python
imls.plot(kind='barh', x='State', y='Revenue') 
```


    <IPython.core.display.Javascript object>



<img src="data:image/png;base64,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AADYRRCwaf78+erSpYtatWqlvn37qkmTJjr99NMj3i/SIKERI0bU+50Fs2fPtj5QqGmi6803lhYAIDKCgE2nnHKKSktLQ5MFV69erauvvjri/SINEuKlAYIAALiBIGBT1bcOVv+iodNOOy3i/SINEtqxY4dSUlLqvFkwJSVFO3futPTYCAIEAQCwiyBg02mnnabKykpdeOGFevDBB/XSSy+pZ8+eEe8XaZCQJBUXF2v48OGhjw8OHz7c8lcQS2YVEwDgDJN6hyNBYMWKFfr222+1detWnX322erXr59ee+01J351RCYVEwDgDJN6hyNB4MMPP7R0mRtMKiYAwBkm9Y6YHzEcabrgypUrFRcXp1mzZoWu37RpkwKBgKX9TSomAMAZJvWOqAaBvXv3avPmzcrKylJJSYk2b96szZs364033lBGRoalPSJNF1y5cqU6duyolJQU7d27V5K9IJAWH6+SzF6+WACAE4MgYNH999+vLl26qGnTpurSpYu6dOmirl27KhgMWp42GGm64MqVK5Wfn68bb7xRN9xwgySCAEEAAKKLIGDTnXfeKUnaunWr7rvvPr388suW7xtpumBVENi7d69SUlL0+eefEwQIAgAQVQQBi84++2ytX79ekrRz5061bdtWw4cPV69evfTHP/7R0h6RpgtWBQFJmjVrli677LKwQaD2ZMGWjRu73qAJAgDgLQQBi7KyskL//ec//1ljxoyRJJWWluqUU06xtEek6YLVg8APP/ygTp066cknn+SMAEEAAKKGIGBR9U8GXHDBBZo3b16914UTabpg9SAgSXPnzlWXLl341AAAIGpM6h1RDQL5+fnavn27vv/+e7Vr106ffPJJ6LrMzExLe0SaLlg7CFRUVCgjI4MgAACIGpN6R1SDwOLFi9W+fXulp6dr7NixocvfeOMNDRs2LJq/2jKTigkAcIZJvSPqnxrYvXu31q9fr8rKytBlO3fu1Jdffnnce1oZMlT9LEE4JhUTAOAMk3qHIx8fPNGsDBkiCAAAosWk3uHZIGBlyJAV8W3jlTM/h+WRBQCxgCDgMqtDhqwgCHhrAUAsIAi4zM6QodpqDxRqnNDY9ebGIggA8BaCgMvsDBmKhDMC3loAEAsIAi6zO2QoHJOKCQBwhkm9w/NBoDqCAADACSb1Dk8GgRPJpGICAJxhUu/wRBCwMkAoISFBwWAwtKpPMgzHpGICAJxhUu/wTBA4UQOEajOpmAAAZ5jUOzwTBE7UAKHa0ls1kgpb21sAAF8jCDjMygCh2i8NzJgxw9LeBAEAgF0EAYf9JwOEaqs9UCipWRxBAABgC0HAYSdygFBtnBEAANhFEHDYiRwgVBtBAABgF0HAYVYGCNV+j8CQIUMs7W1SMQEAzjCpd3giCESTScUEADjDpN5BEDComAAAZ5jUO2I+CFidKtinTx9lZ2crOztbU6dOVWlpqaX9TSomAMAZJvUOTwQBO1MFDx48qEmTJikvL09Hjx6NuH+TlskKzChincAFAKYjCDjoeKYKlpeXq3PnzioqityUCAIEAQCwiyDgICtTBev76ODo0aN1zz33RNyfIEAQAAC7CAIOOt6pguedd169QaD2ZMFGzVq43jhNWwBgOoKAg45nqmB5eblOPvlkLVu2LOL+nBEgCACAXQQBB9mdKnjo0CFbbxY0qZgAAGeY1Ds8FQSqq2+qYHZ2trKysjRlyhQ+PggAiBqTekfMB4FoM6mYAABnmNQ7Yj4IRBooVOWxxx5TXFyc1q5da2t/k4oJAHCGSb3DE0Eg3EChKgMHDtSQIUN01VVX2drfpGICAJxhUu/wRBAIN1BIkj766CN17NhRO3bsUFJSkg4ePGh5fz41wKcDAMAugoCDIg0UkqTp06frlltukSSNGTNG8+bNs7w/QYAgAAB2EQQcFGmgUHl5udLS0vTxxx9LkpYuXaqCgoIG92OgEEEAAP5TBAEHRRootGTJEjVr1kyBQECBQECdO3dWfHx8vR85rA9nBAgCAGAXQcBBkQYKjRo1SnPnzq1xn2nTpmnq1KmW9jepmAAAZ5jUOzwVBKorLCzUL37xCyUkJGjfvn01rtuwYYNSUlJUVlYWcX+TigkAcIZJvSPmg0C0mVRMAIAzTOodngsCDZ0hqKysVCAQ0NChQ23tZ1IxAQDOMKl3GBME/vGPfyg3N1fJycn6/PPPLe9nUjEBAM4wqXcYEwQuueQSzZkzR5MnT9ZvfvMby/s1TmmvtH+u9+0CANhHEHBRfUFg//79SkpKUmlpqTZs2KCTTjpJx44ds7QfQQAAYBdBwEX1BYEHHnhAl156aejn/Px8vfLKK/Xev85AocSWrjdjggAAeAtBwEX1BYFgMKi0tLTQUKF27drpoosusrQfZwQAAHYRBFxUOwi8++676tSpU42XAvbv36+WLVtqz549EfcjCAAA7CIIuCgQCCgtLS10ar958+aaMGFCnduNGTNGs2fPjrifScUEADjDpN7huSBwoplUTACAM0zqHQQBg4oJAHCGSb3Dc0Gg+nsEDh8+rNGjR6tdu3YaMGBAjfcJ3HXXXTr33HMj7mdSMQEAzjCpd3g2CHz33XcaPHiwJk2apGPHjmnkyJGh9wQUFxerU6dO2rVrV8T9UlKa6PUV3Ty9AADOIgi4KBAI6J///Kf69u2rGTNmhC7/+uuvlZ6eruLiYvXr10+LFi2ytB9BAABgF0HARYFAQMnJybr11lvrXPe3v/1NSUlJuvzyyy3vRxAAANhFEHBRIBDQz372M3Xv3l1fffVVnetPOukkbdiwocH7154smJjYyPVGThAAAG8hCLio6j0C99xzj7p166Yvv/yy3uut4owAAMAugoCLqjf6P//5z+ratau++OKLeq+3wqRiAgCcYVLv8HQQkH481R8IBPT555/Xe30kJhUTAOAMk3qH54LAiWZSMQEAzjCpd3gqCNQ3TOiSSy7Rxo0bdeaZZyo3N1e9e/dWv379LJ8VMKmYAABnmNQ7PBkEag8TysnJ0UsvvRS63VdffaVvvvnG0p4mFRMA4AyTeofngkB9w4Rat26t999//7j2bNWqlQoLC11dAABvIQi4pKFhQvfee68SExN11lln6bbbbtMHH3xgeU+CAADALoKAS8INE9q9e7eeeeYZ/epXv1JiYqKeffbZeveoPVCoWbNmBAEAgC0EAZdEGiZU5e6779Z5551naU/OCAAA7CIIuKShYUJLlixReXm5JKmiokLjx4/XlClTLO1pUjEBAM4wqXd4NghI/zdM6IorrlBGRoZOOeUUZWdn66qrrtJ3331naU+TigkAcIZJvcNTQSAaTComAMAZJvUOzwaBqrMDP//5z9W0aVN99tlnoeumTZtm+bV3k4oJAHCGSb3DiCDQpUsXXXrppaHrCAIAgGgyqXcYEQTuuecepaenh4YK2QkCHVqmavuMNawoLgAwDUEgBlQPAg899JAeffRRnX322ZIIArG2AMA0BIEYUDsIHD16VJmZmfrHP/4RNgjUHijUqlmi643S9AUApiEIxIDaQUCSFi9erL59++qmm27ijEAMLQAwDUEgBtQXBCRpwIAB6tKlC0EghhYAmIYg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FhOPy8RjkjguLzHxmCQzj8vEY4oW3weB2bNnu/0QosLE4zLxmCSOy0tMPCbJzOMy8ZiixfdBAAAAPyMIAADgYwQBAAB8zBdB4NNPP9Vpp52mnj17qn///tq8eXO9t5s1a5a6deumbt266Y477nD4Udpn5bieffZZ9enTR71791ZOTk690xljidVaSdKePXvUvn17jR071sFHeHysHteqVavUr18/ZWdnKzMz09ZXarvBynEdPnxYP//5z5WTk6PevXvrvPPO0969e114tNZMnjxZgUBAcXFx2rRpU4O389LzhZVj8tpzhWS9VpK3aLvrdAAABo1JREFUni+c5osgcOaZZ+qJJ56Q9ON3FgwYMKDObVavXq3s7Gx9//33OnLkiPLz87V8+XKHH6k9Vo5r3bp12rVrlyTp22+/Vffu3bVu3TonH6YtVo6pykUXXaSrrrrKE3+xrRzXzp07FQgEVFJSIunHBnrgwAEnH6ZtVo7r/vvv19ixY0NfBDZx4kTdfPPNTj5MW1avXq3t27crEAg02Fy89nxh5Zi89lwhWTuuKl56vnCa8UHgm2++UVJSkioqKiRJlZWVSktL07Zt22rc7rrrrtOf/vSn0M8PP/ywfv7znzv4SO2xely1jRo1SgsXLnTgEdpn55ieeuopXX/99XriiSdi/i+21eO6/fbbdfvtt7vwCI+P1eO6//77NWLECJWVlamiokKXXnqpHnjgARcesT3hmovXni+qWGmYVWL5uaK2SMflpecLNxgfBN577z1lZWXVuKx///5avXp1jcvOPfdcPffcc6Gfly1bpjPPPNORx3g8rB5XdZs3b1a7du20c+fOaD+842L1mHbu3Km+ffvq0KFDnviLbfW4LrjgAt10000aOnSogsGg/vu//1s//PCDkw/VFqvHdfjwYV1yySVKSkpSu3btNGLECEvfDOq2cM3Fa88XVawGgVh/rqgt3HF57fnCDb4IAtnZ2TUu69evX71B4Pnnnw/9XFRUFNN/sa0eV5Xt27erR48eNY4x1lg9ppEjR+r111+XJE/8xbbz/2Dfvn1VWlqqiooKXXnllTF9Ct3qcS1dulSXXnqpDh8+rLKyMo0fP16FhYUOPtLjEykIeOn5ooqVIOCF54rawh2X154v3GB8EPjmm2/UunVrI18asHJc0o+JODMzU/Pnz3f4Udpj9Zjatm2rQCCgQCCg5ORktWjRQuecc44Lj9gaq8d1/fXX6ze/+U3o52XLlmnw4MEOPlJ7rB7XqFGjavzruaioSD/96U+dfKjHxY8vDXjluaK2cMfltecLNxgfBCRp8ODBNd7QVFBQUOc2K1euVO/evWu8+eeVV15x+JHaY+W4vv76a/Xq1UuPP/64w4/u+Fg5puq8kvCtHNcbb7yhM844Q0eOHJH04zuib7jhBicfpm1Wjmvy5MmaMGGCKisrVVlZqV/96le67rrrHH6k9oVrLl58vpDCH5PXniuqs/qSh1eeL5zmiyDw8ccfa8CAAerZs6fy8/NVXFwsSRoxYoTefffd0O1mzpyprl27qmvXrvr1r3/t1sO1zMpxTZw4US1atFAwGAytWP6LbrVWVbzyF9vqcd1zzz3q1auXcnJydOmll+rbb7916yFbYuW49u/fr7FjxyorK0vZ2dm66KKLtH//fjcfdljXXXed0tPT1aRJE6Wlpal79+6SvP18YeWYvPZcIVmvVRWvPF84zRdBAAAA1I8gAACAjxEEAADwMYIAAAA+RhAAAMDHCAIAAOPZ+YKiKk8++aRyc3PVu3dvnXXWWfryyy+j/CjdQRAAABjPzhcUSdJHH32kjh07avfu3ZKk+fPna+TIkdF+mK4gCAAAfKN2EHjnnXd05plnKj8/X3l5eXrhhRck/Tgga8SIEaHb7du3T40aNdK+ffscf8zRRhAAAPhG9SBw4MAB5eXl6euvv5Yk7d27V507d9auXbu0ZcsWtW/fXlu2bJEk3XfffYqLi9P777/v2mOPFoIAAMA3qgeBZcuWKSkpqcY0xZNPPlmrVq2SJC1evFgDBgxQ//79NXPmTCUlJWnjxo1uPvyoIAgAAHyjehAoKirSoEGDLN1v165datasWUx/NfjxIggAAHyjehAoLS1Vhw4dtGLFitD169evV1lZmSSFXjI4evSofvazn+mmm25y/gE7gCAAADBeQ19Q9O6772rIkCHKzc1VVlaWhg0bpsOHD0uShg0bpqysLHXv3l2TJ08OfTOoaQgCAAD4GEEAAAAfIwgAAOBjBAEAAHyMIAAAgI8RBAAA8DGCAAAAPkYQAADAxwgCAAD4GEEAAAAfIwgAAOBjBAEAAHyMIAAAgI8RBAAA8DGCAAAAPkYQAADAxwgCAAD4GEEAAAAfIwgAAOBjBAEAAHyMIAAAgI8RBAAA8DGCAAAAPkYQAADAxwgCAAD4GEEAAAAfIwgAAOBjBAEAAHyMIAAAgI8RBAAA8DGCAAAAPkYQAADAxwgCAAD4GEEAAAAfIwgAAOBjBAEAAHyMIAAAgI8RBAAA8DGCAAAAPkYQAADAxwgCAAD4GEEAAAAf+3+VDUDBcio+lwAAAABJRU5ErkJggg==" width="642.5">





    <matplotlib.axes._subplots.AxesSubplot at 0x18eb0e43d68>



## Univariate Data

*What might you want to know from a single dimension?*

Most often: distribution / density

`kind = 'hist'`, `kind = 'density'` (or 'kde')

### Histogram

Essentially, a bar chart that organizes continuous data into bins.


```python
beer[['abv']].head()
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
      <th>abv</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.050</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.066</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.071</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.090</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.075</td>
    </tr>
  </tbody>
</table>
</div>




```python
beer['abv'].plot(kind='hist')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1dde5785c50>




![png](output_60_1.png)


- *What are the intervals for the bins?*
- *Is this a DataFrame or Series being plotted?*
  - *Will the other datatype plot in the same way?*

To change, use the `bins` argument to specify how many bars there will be across the range.


```python
beer.abv.plot(kind='hist', bins=20)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x18eb57755c0>




![png](output_63_1.png)



```python
beer.abv.plot(kind='hist', bins=50)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x18eb66d7a58>




![png](output_64_1.png)


Too little:


```python
beer.abv.plot(kind='hist', bins=3)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x18eb6d4fe80>




![png](output_66_1.png)


Too much:


```python
beer.abv.plot(kind='hist', bins=100)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x18eb80a6128>




![png](output_68_1.png)


### Kernel Density

Like a histogram, but with an interpolated line tracing the distribution shape.


```python
beer.abv.plot(kind='density')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x18eb97f57b8>




![png](output_70_1.png)


- interactive plots (note active plots)
- There are many options for customizing plots - this is where good online searching can help you!

## Multi-variate version of a histogram: Hexplot

- Color is used to show density across two dimensions.


```python
cats.plot(kind='hexbin', x='Bwt', y='Hwt', gridsize=15)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1dde58c4a20>




![png](output_73_1.png)


## Pie Charts: Univariate data that adds to a whole

`kind = 'pie'`


```python
counts_by_category = beer.type.value_counts()
counts_by_category.head(2)
```




    American IPA               424
    American Pale Ale (APA)    245
    Name: type, dtype: int64




```python
counts_by_category.plot(kind='pie')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1dde597b860>




![png](output_76_1.png)


Incomplete:


```python
counts_by_category[:5].plot(kind='pie')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x18eb9fb4198>




![png](output_78_1.png)


*How might we combine all the other values into an 'other' category?*

(No trick, just break down the problem)

## Line Chart

The default plot. Useful for showing change in continuous or interval data.


```python
unique_movies = movies[['title', 'year']].drop_duplicates()
movies_by_year = unique_movies.groupby('year')[['title']].count()
movies_by_year.sample(1)
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
    </tr>
    <tr>
      <th>year</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1962</th>
      <td>41</td>
    </tr>
  </tbody>
</table>
</div>




```python
movies_by_year.plot() 
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1dde5cb91d0>




![png](output_82_1.png)



```python
movies_by_year.plot(kind='area')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x1dde5cbc0f0>




![png](output_83_1.png)


## <center>Exercises</center>

## <center>Where to next?</center>

*matplotlib* is fairly low-level: it's very customizable, but more advanced to use.

Plotting in Pandas is higher-level: it builds on top of *matplotlib*, making some choices for you in exchange for ease of use.

If the out of the box plots don't work:

- (1) **Customizing default charts**: Read the pandas [documentation](https://pandas.pydata.org/pandas-docs/stable/visualization.html)
- (3) **Use matplotlib directly**: Use the [visualization gallery](https://matplotlib.org/gallery.html) for ideas.

![](../images/matplot-gallery.png)

### Seaborn

Looking for more advanced visualizations without the complexity of *matplotlib*? 

*Seaborn* is a high-level visualization library that makes certain types of *advanced* graphs easier to plot.


```python
import seaborn as sns
```

[Seaborn Gallery](https://seaborn.pydata.org/examples/index.html)
![Seaborn Gallery](../images/seaborn-gallery.png)

#### Linear Regression with `lmplot`


```python
import seaborn as sns
sns.lmplot(data=cats, x='Bwt', y='Hwt')
```




    <seaborn.axisgrid.FacetGrid at 0x1dde6da8a58>




![png](output_92_1.png)


Various alternate regression fits are possible: read the docs!


```python
sns.lmplot(data=cats, x='Bwt', y='Hwt', logx=True)
```




    <seaborn.axisgrid.FacetGrid at 0x1dde7958908>




![png](output_94_1.png)

