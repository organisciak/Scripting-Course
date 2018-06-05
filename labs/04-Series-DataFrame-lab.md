_[Link to Notebook Version of Lab](https://github.com/organisciak/Scripting-Course/blob/master/labs/04-Series-DataFrame-lab.ipynb)_


## Lab 4: Series and DataFrame


```python
import pandas as pd
```

Create a Series with the following code:


```python
titles = ['Dumb and Dumber To', 'Alien 3', 'Moonraker', 'Shall We Dance', 'Top Gun', 'Quantum of Solace', 'Wild Hogs', 'Apollo 13', 'Cloudy with a Chance of Meatballs 2', 'Hook', "Bridget Jones's Diary", 'Sense and Sensibility', 'Save the Last Dance', 'Finding Neverland', 'Life Is Beautiful', 'Les Miserables (2012)', 'Memoirs of a Geisha', 'Raiders of the Lost Ark (IMAX)', "A Knight's Tale", 'Where the Wild Things Are', 'Donnie Brasco', 'Star Trek', 'Dances with Wolves', 'Total Recall (2012)', 'Alexander', 'Sister Act', 'X-Men:First Class', 'My Big Fat Greek Wedding', 'Red', 'Shark Tale']
boxoffice = [169837010, 159814498, 210308099, 170128460, 356830601, 586090727, 253625427, 355237933, 274325949, 300854823, 281929795, 134582776, 131706809, 116766556, 229163264, 441809770, 162242962, 248159971, 117487473, 100086793, 124909762, 385680446, 424208848, 198467168, 167298192, 231605150, 353624124, 368744044, 199006387, 367275019]
bodf = pd.Series(boxoffice, index=titles)
```

`bodf` is a Series with 30 box office takes, with the movie names as the index.


```python
bodf
```




    Dumb and Dumber To                     169837010
    Alien 3                                159814498
    Moonraker                              210308099
    Shall We Dance                         170128460
    Top Gun                                356830601
    Quantum of Solace                      586090727
    Wild Hogs                              253625427
    Apollo 13                              355237933
    Cloudy with a Chance of Meatballs 2    274325949
    Hook                                   300854823
    Bridget Jones's Diary                  281929795
    Sense and Sensibility                  134582776
    Save the Last Dance                    131706809
    Finding Neverland                      116766556
    Life Is Beautiful                      229163264
    Les Miserables (2012)                  441809770
    Memoirs of a Geisha                    162242962
    Raiders of the Lost Ark (IMAX)         248159971
    A Knight's Tale                        117487473
    Where the Wild Things Are              100086793
    Donnie Brasco                          124909762
    Star Trek                              385680446
    Dances with Wolves                     424208848
    Total Recall (2012)                    198467168
    Alexander                              167298192
    Sister Act                             231605150
    X-Men:First Class                      353624124
    My Big Fat Greek Wedding               368744044
    Red                                    199006387
    Shark Tale                             367275019
    dtype: int64



**Questions**

- Write the code to return the first 7 rows of `bodf`.
- What is the average box office take in this sample of films, to the nearest dollar?
    - `254060295`
    - `230384207`
    - `248159971`
- Write the code to return just the movies that have made more than $250m.
- What does `bodf.cumsum()` do?
- How would you return the Box Office take for *Dances with Wolves*?
- What SQL clause is comparable to `bodf.sort_values()`?
- How would you sort `bodf` in descending order?

## DataFrame

Use the following code to read a CSV of fuel economies to a Dataframe.


```python
mpg = pd.read_csv('http://vincentarelbundock.github.io/Rdatasets/csv/ggplot2/mpg.csv', index_col=0)
```

Here's what the data looks like:


```python
mpg.head(5)
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
      <th>manufacturer</th>
      <th>model</th>
      <th>displ</th>
      <th>year</th>
      <th>cyl</th>
      <th>trans</th>
      <th>drv</th>
      <th>cty</th>
      <th>hwy</th>
      <th>fl</th>
      <th>class</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>audi</td>
      <td>a4</td>
      <td>1.8</td>
      <td>1999</td>
      <td>4</td>
      <td>auto(l5)</td>
      <td>f</td>
      <td>18</td>
      <td>29</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>2</th>
      <td>audi</td>
      <td>a4</td>
      <td>1.8</td>
      <td>1999</td>
      <td>4</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>21</td>
      <td>29</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>3</th>
      <td>audi</td>
      <td>a4</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>manual(m6)</td>
      <td>f</td>
      <td>20</td>
      <td>31</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>4</th>
      <td>audi</td>
      <td>a4</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>auto(av)</td>
      <td>f</td>
      <td>21</td>
      <td>30</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>5</th>
      <td>audi</td>
      <td>a4</td>
      <td>2.8</td>
      <td>1999</td>
      <td>6</td>
      <td>auto(l5)</td>
      <td>f</td>
      <td>16</td>
      <td>26</td>
      <td>p</td>
      <td>compact</td>
    </tr>
  </tbody>
</table>
</div>



**Questions**:

- What is the code to select rows 5 to 10 of `mpg`?
- How would you select all rows with a class of 'midsize'?
- How would you select all rows with a class of 'midsize' and `hwy` economy of 24 miles per gallon? (Tip: easiest way is to use `and`, though there are other ways)
- What is the average city fuel economy for compact cars?
   - 16.9
   - 28.3
   - 23.4
   - 20.1
- Convert this SQL to the equivalent in Pandas:

```sql
SELECT model, manufacturer FROM mpg
WHERE year > 2005
ORDER BY hwy DESC
```

- Which car had the best city fuel economy in 1999?
    - Toyota Corolla
    - Nissan Altima
    - Volkswagen New Beetle
    - Toyota Camry Solara

- How many cars have a highway economy that's more than 10 MPG better on highways than in cities?

## Split Apply Combine - Initial Questions

**Questions**

- In plain English, what would I *split* on, and what type of code would I *apply* for the following questions:
    - Get the number of cars from each manufacturer.
    - Figure out how cylinders affect fuel economy.


```python
mpg
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
      <th>manufacturer</th>
      <th>model</th>
      <th>displ</th>
      <th>year</th>
      <th>cyl</th>
      <th>trans</th>
      <th>drv</th>
      <th>cty</th>
      <th>hwy</th>
      <th>fl</th>
      <th>class</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>audi</td>
      <td>a4</td>
      <td>1.8</td>
      <td>1999</td>
      <td>4</td>
      <td>auto(l5)</td>
      <td>f</td>
      <td>18</td>
      <td>29</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>2</th>
      <td>audi</td>
      <td>a4</td>
      <td>1.8</td>
      <td>1999</td>
      <td>4</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>21</td>
      <td>29</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>3</th>
      <td>audi</td>
      <td>a4</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>manual(m6)</td>
      <td>f</td>
      <td>20</td>
      <td>31</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>4</th>
      <td>audi</td>
      <td>a4</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>auto(av)</td>
      <td>f</td>
      <td>21</td>
      <td>30</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>5</th>
      <td>audi</td>
      <td>a4</td>
      <td>2.8</td>
      <td>1999</td>
      <td>6</td>
      <td>auto(l5)</td>
      <td>f</td>
      <td>16</td>
      <td>26</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>6</th>
      <td>audi</td>
      <td>a4</td>
      <td>2.8</td>
      <td>1999</td>
      <td>6</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>18</td>
      <td>26</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>7</th>
      <td>audi</td>
      <td>a4</td>
      <td>3.1</td>
      <td>2008</td>
      <td>6</td>
      <td>auto(av)</td>
      <td>f</td>
      <td>18</td>
      <td>27</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>8</th>
      <td>audi</td>
      <td>a4 quattro</td>
      <td>1.8</td>
      <td>1999</td>
      <td>4</td>
      <td>manual(m5)</td>
      <td>4</td>
      <td>18</td>
      <td>26</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>9</th>
      <td>audi</td>
      <td>a4 quattro</td>
      <td>1.8</td>
      <td>1999</td>
      <td>4</td>
      <td>auto(l5)</td>
      <td>4</td>
      <td>16</td>
      <td>25</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>10</th>
      <td>audi</td>
      <td>a4 quattro</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>manual(m6)</td>
      <td>4</td>
      <td>20</td>
      <td>28</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>11</th>
      <td>audi</td>
      <td>a4 quattro</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>auto(s6)</td>
      <td>4</td>
      <td>19</td>
      <td>27</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>12</th>
      <td>audi</td>
      <td>a4 quattro</td>
      <td>2.8</td>
      <td>1999</td>
      <td>6</td>
      <td>auto(l5)</td>
      <td>4</td>
      <td>15</td>
      <td>25</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>13</th>
      <td>audi</td>
      <td>a4 quattro</td>
      <td>2.8</td>
      <td>1999</td>
      <td>6</td>
      <td>manual(m5)</td>
      <td>4</td>
      <td>17</td>
      <td>25</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>14</th>
      <td>audi</td>
      <td>a4 quattro</td>
      <td>3.1</td>
      <td>2008</td>
      <td>6</td>
      <td>auto(s6)</td>
      <td>4</td>
      <td>17</td>
      <td>25</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>15</th>
      <td>audi</td>
      <td>a4 quattro</td>
      <td>3.1</td>
      <td>2008</td>
      <td>6</td>
      <td>manual(m6)</td>
      <td>4</td>
      <td>15</td>
      <td>25</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>16</th>
      <td>audi</td>
      <td>a6 quattro</td>
      <td>2.8</td>
      <td>1999</td>
      <td>6</td>
      <td>auto(l5)</td>
      <td>4</td>
      <td>15</td>
      <td>24</td>
      <td>p</td>
      <td>midsize</td>
    </tr>
    <tr>
      <th>17</th>
      <td>audi</td>
      <td>a6 quattro</td>
      <td>3.1</td>
      <td>2008</td>
      <td>6</td>
      <td>auto(s6)</td>
      <td>4</td>
      <td>17</td>
      <td>25</td>
      <td>p</td>
      <td>midsize</td>
    </tr>
    <tr>
      <th>18</th>
      <td>audi</td>
      <td>a6 quattro</td>
      <td>4.2</td>
      <td>2008</td>
      <td>8</td>
      <td>auto(s6)</td>
      <td>4</td>
      <td>16</td>
      <td>23</td>
      <td>p</td>
      <td>midsize</td>
    </tr>
    <tr>
      <th>19</th>
      <td>chevrolet</td>
      <td>c1500 suburban 2wd</td>
      <td>5.3</td>
      <td>2008</td>
      <td>8</td>
      <td>auto(l4)</td>
      <td>r</td>
      <td>14</td>
      <td>20</td>
      <td>r</td>
      <td>suv</td>
    </tr>
    <tr>
      <th>20</th>
      <td>chevrolet</td>
      <td>c1500 suburban 2wd</td>
      <td>5.3</td>
      <td>2008</td>
      <td>8</td>
      <td>auto(l4)</td>
      <td>r</td>
      <td>11</td>
      <td>15</td>
      <td>e</td>
      <td>suv</td>
    </tr>
    <tr>
      <th>21</th>
      <td>chevrolet</td>
      <td>c1500 suburban 2wd</td>
      <td>5.3</td>
      <td>2008</td>
      <td>8</td>
      <td>auto(l4)</td>
      <td>r</td>
      <td>14</td>
      <td>20</td>
      <td>r</td>
      <td>suv</td>
    </tr>
    <tr>
      <th>22</th>
      <td>chevrolet</td>
      <td>c1500 suburban 2wd</td>
      <td>5.7</td>
      <td>1999</td>
      <td>8</td>
      <td>auto(l4)</td>
      <td>r</td>
      <td>13</td>
      <td>17</td>
      <td>r</td>
      <td>suv</td>
    </tr>
    <tr>
      <th>23</th>
      <td>chevrolet</td>
      <td>c1500 suburban 2wd</td>
      <td>6.0</td>
      <td>2008</td>
      <td>8</td>
      <td>auto(l4)</td>
      <td>r</td>
      <td>12</td>
      <td>17</td>
      <td>r</td>
      <td>suv</td>
    </tr>
    <tr>
      <th>24</th>
      <td>chevrolet</td>
      <td>corvette</td>
      <td>5.7</td>
      <td>1999</td>
      <td>8</td>
      <td>manual(m6)</td>
      <td>r</td>
      <td>16</td>
      <td>26</td>
      <td>p</td>
      <td>2seater</td>
    </tr>
    <tr>
      <th>25</th>
      <td>chevrolet</td>
      <td>corvette</td>
      <td>5.7</td>
      <td>1999</td>
      <td>8</td>
      <td>auto(l4)</td>
      <td>r</td>
      <td>15</td>
      <td>23</td>
      <td>p</td>
      <td>2seater</td>
    </tr>
    <tr>
      <th>26</th>
      <td>chevrolet</td>
      <td>corvette</td>
      <td>6.2</td>
      <td>2008</td>
      <td>8</td>
      <td>manual(m6)</td>
      <td>r</td>
      <td>16</td>
      <td>26</td>
      <td>p</td>
      <td>2seater</td>
    </tr>
    <tr>
      <th>27</th>
      <td>chevrolet</td>
      <td>corvette</td>
      <td>6.2</td>
      <td>2008</td>
      <td>8</td>
      <td>auto(s6)</td>
      <td>r</td>
      <td>15</td>
      <td>25</td>
      <td>p</td>
      <td>2seater</td>
    </tr>
    <tr>
      <th>28</th>
      <td>chevrolet</td>
      <td>corvette</td>
      <td>7.0</td>
      <td>2008</td>
      <td>8</td>
      <td>manual(m6)</td>
      <td>r</td>
      <td>15</td>
      <td>24</td>
      <td>p</td>
      <td>2seater</td>
    </tr>
    <tr>
      <th>29</th>
      <td>chevrolet</td>
      <td>k1500 tahoe 4wd</td>
      <td>5.3</td>
      <td>2008</td>
      <td>8</td>
      <td>auto(l4)</td>
      <td>4</td>
      <td>14</td>
      <td>19</td>
      <td>r</td>
      <td>suv</td>
    </tr>
    <tr>
      <th>30</th>
      <td>chevrolet</td>
      <td>k1500 tahoe 4wd</td>
      <td>5.3</td>
      <td>2008</td>
      <td>8</td>
      <td>auto(l4)</td>
      <td>4</td>
      <td>11</td>
      <td>14</td>
      <td>e</td>
      <td>suv</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>205</th>
      <td>toyota</td>
      <td>toyota tacoma 4wd</td>
      <td>3.4</td>
      <td>1999</td>
      <td>6</td>
      <td>auto(l4)</td>
      <td>4</td>
      <td>15</td>
      <td>19</td>
      <td>r</td>
      <td>pickup</td>
    </tr>
    <tr>
      <th>206</th>
      <td>toyota</td>
      <td>toyota tacoma 4wd</td>
      <td>4.0</td>
      <td>2008</td>
      <td>6</td>
      <td>manual(m6)</td>
      <td>4</td>
      <td>15</td>
      <td>18</td>
      <td>r</td>
      <td>pickup</td>
    </tr>
    <tr>
      <th>207</th>
      <td>toyota</td>
      <td>toyota tacoma 4wd</td>
      <td>4.0</td>
      <td>2008</td>
      <td>6</td>
      <td>auto(l5)</td>
      <td>4</td>
      <td>16</td>
      <td>20</td>
      <td>r</td>
      <td>pickup</td>
    </tr>
    <tr>
      <th>208</th>
      <td>volkswagen</td>
      <td>gti</td>
      <td>2.0</td>
      <td>1999</td>
      <td>4</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>21</td>
      <td>29</td>
      <td>r</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>209</th>
      <td>volkswagen</td>
      <td>gti</td>
      <td>2.0</td>
      <td>1999</td>
      <td>4</td>
      <td>auto(l4)</td>
      <td>f</td>
      <td>19</td>
      <td>26</td>
      <td>r</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>210</th>
      <td>volkswagen</td>
      <td>gti</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>manual(m6)</td>
      <td>f</td>
      <td>21</td>
      <td>29</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>211</th>
      <td>volkswagen</td>
      <td>gti</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>auto(s6)</td>
      <td>f</td>
      <td>22</td>
      <td>29</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>212</th>
      <td>volkswagen</td>
      <td>gti</td>
      <td>2.8</td>
      <td>1999</td>
      <td>6</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>17</td>
      <td>24</td>
      <td>r</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>213</th>
      <td>volkswagen</td>
      <td>jetta</td>
      <td>1.9</td>
      <td>1999</td>
      <td>4</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>33</td>
      <td>44</td>
      <td>d</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>214</th>
      <td>volkswagen</td>
      <td>jetta</td>
      <td>2.0</td>
      <td>1999</td>
      <td>4</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>21</td>
      <td>29</td>
      <td>r</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>215</th>
      <td>volkswagen</td>
      <td>jetta</td>
      <td>2.0</td>
      <td>1999</td>
      <td>4</td>
      <td>auto(l4)</td>
      <td>f</td>
      <td>19</td>
      <td>26</td>
      <td>r</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>216</th>
      <td>volkswagen</td>
      <td>jetta</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>auto(s6)</td>
      <td>f</td>
      <td>22</td>
      <td>29</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>217</th>
      <td>volkswagen</td>
      <td>jetta</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>manual(m6)</td>
      <td>f</td>
      <td>21</td>
      <td>29</td>
      <td>p</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>218</th>
      <td>volkswagen</td>
      <td>jetta</td>
      <td>2.5</td>
      <td>2008</td>
      <td>5</td>
      <td>auto(s6)</td>
      <td>f</td>
      <td>21</td>
      <td>29</td>
      <td>r</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>219</th>
      <td>volkswagen</td>
      <td>jetta</td>
      <td>2.5</td>
      <td>2008</td>
      <td>5</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>21</td>
      <td>29</td>
      <td>r</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>220</th>
      <td>volkswagen</td>
      <td>jetta</td>
      <td>2.8</td>
      <td>1999</td>
      <td>6</td>
      <td>auto(l4)</td>
      <td>f</td>
      <td>16</td>
      <td>23</td>
      <td>r</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>221</th>
      <td>volkswagen</td>
      <td>jetta</td>
      <td>2.8</td>
      <td>1999</td>
      <td>6</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>17</td>
      <td>24</td>
      <td>r</td>
      <td>compact</td>
    </tr>
    <tr>
      <th>222</th>
      <td>volkswagen</td>
      <td>new beetle</td>
      <td>1.9</td>
      <td>1999</td>
      <td>4</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>35</td>
      <td>44</td>
      <td>d</td>
      <td>subcompact</td>
    </tr>
    <tr>
      <th>223</th>
      <td>volkswagen</td>
      <td>new beetle</td>
      <td>1.9</td>
      <td>1999</td>
      <td>4</td>
      <td>auto(l4)</td>
      <td>f</td>
      <td>29</td>
      <td>41</td>
      <td>d</td>
      <td>subcompact</td>
    </tr>
    <tr>
      <th>224</th>
      <td>volkswagen</td>
      <td>new beetle</td>
      <td>2.0</td>
      <td>1999</td>
      <td>4</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>21</td>
      <td>29</td>
      <td>r</td>
      <td>subcompact</td>
    </tr>
    <tr>
      <th>225</th>
      <td>volkswagen</td>
      <td>new beetle</td>
      <td>2.0</td>
      <td>1999</td>
      <td>4</td>
      <td>auto(l4)</td>
      <td>f</td>
      <td>19</td>
      <td>26</td>
      <td>r</td>
      <td>subcompact</td>
    </tr>
    <tr>
      <th>226</th>
      <td>volkswagen</td>
      <td>new beetle</td>
      <td>2.5</td>
      <td>2008</td>
      <td>5</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>20</td>
      <td>28</td>
      <td>r</td>
      <td>subcompact</td>
    </tr>
    <tr>
      <th>227</th>
      <td>volkswagen</td>
      <td>new beetle</td>
      <td>2.5</td>
      <td>2008</td>
      <td>5</td>
      <td>auto(s6)</td>
      <td>f</td>
      <td>20</td>
      <td>29</td>
      <td>r</td>
      <td>subcompact</td>
    </tr>
    <tr>
      <th>228</th>
      <td>volkswagen</td>
      <td>passat</td>
      <td>1.8</td>
      <td>1999</td>
      <td>4</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>21</td>
      <td>29</td>
      <td>p</td>
      <td>midsize</td>
    </tr>
    <tr>
      <th>229</th>
      <td>volkswagen</td>
      <td>passat</td>
      <td>1.8</td>
      <td>1999</td>
      <td>4</td>
      <td>auto(l5)</td>
      <td>f</td>
      <td>18</td>
      <td>29</td>
      <td>p</td>
      <td>midsize</td>
    </tr>
    <tr>
      <th>230</th>
      <td>volkswagen</td>
      <td>passat</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>auto(s6)</td>
      <td>f</td>
      <td>19</td>
      <td>28</td>
      <td>p</td>
      <td>midsize</td>
    </tr>
    <tr>
      <th>231</th>
      <td>volkswagen</td>
      <td>passat</td>
      <td>2.0</td>
      <td>2008</td>
      <td>4</td>
      <td>manual(m6)</td>
      <td>f</td>
      <td>21</td>
      <td>29</td>
      <td>p</td>
      <td>midsize</td>
    </tr>
    <tr>
      <th>232</th>
      <td>volkswagen</td>
      <td>passat</td>
      <td>2.8</td>
      <td>1999</td>
      <td>6</td>
      <td>auto(l5)</td>
      <td>f</td>
      <td>16</td>
      <td>26</td>
      <td>p</td>
      <td>midsize</td>
    </tr>
    <tr>
      <th>233</th>
      <td>volkswagen</td>
      <td>passat</td>
      <td>2.8</td>
      <td>1999</td>
      <td>6</td>
      <td>manual(m5)</td>
      <td>f</td>
      <td>18</td>
      <td>26</td>
      <td>p</td>
      <td>midsize</td>
    </tr>
    <tr>
      <th>234</th>
      <td>volkswagen</td>
      <td>passat</td>
      <td>3.6</td>
      <td>2008</td>
      <td>6</td>
      <td>auto(s6)</td>
      <td>f</td>
      <td>17</td>
      <td>26</td>
      <td>p</td>
      <td>midsize</td>
    </tr>
  </tbody>
</table>
<p>234 rows × 11 columns</p>
</div>


