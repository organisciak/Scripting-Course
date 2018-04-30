# Datasets

Here are some notable dataset sources for working with. Some of these we'll use in class.

## Structured

- ‎[Hathifiles](https://www.hathitrust.org/hathifiles)
- ‎[Powerhouse Museum](https://data.nsw.gov.au/data/dataset/powerhouse-museum-collection-simplified-dataset)
- ‎[Tate Museum](https://github.com/tategallery/collection)

## Semi-Structured

- [DPLA](https://pro.dp.la/developers/bulk-download)

## Various

- ‎[UC Irvine Datasets](https://archive.ics.uci.edu/ml/index.php)
- [Kaggle](https://www.kaggle.com/datasets)
- ‎[SNAP](https://snap.stanford.edu/data/)
- [RDatasets](https://vincentarelbundock.github.io/Rdatasets/)
- [Awesome Public Datasets](https://github.com/awesomedata/awesome-public-datasets)

## Datasets from Class

```
cats = pd.read_csv('https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/cat_data.tsv', sep='\t')
beer = pd.read_csv('https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/beers.csv')
movies = pd.read_csv('https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/movielens_small.csv')
imls = pd.read_csv('https://raw.githubusercontent.com/organisciak/Scripting-Course/master/data/imls_mini_by_state.csv')
mpg = pd.read_csv('http://vincentarelbundock.github.io/Rdatasets/csv/ggplot2/mpg.csv', index_col=0)
```