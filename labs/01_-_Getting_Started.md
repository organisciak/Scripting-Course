_[Link to Notebook Version of Lab](https://github.com/organisciak/Scripting-Course/blob/master/labs/01%20-%20Getting%20Started.ipynb)_


# Week 1 Lab Task
*This lab is ungraded and has no submission*

This week is about getting started with powerful tools that will underlie many of the skills you learn in the course. 

Much of the effort today is in setting up your computer.

In this course we'll be using the Python programming language, using an innovative environment called Jupyter Notebooks. This will be your window to most of our work in databases.

Your _environment_ is similar to your local workspace. Look at your desk: how do you organize your pens, paper, mouse, monitor? Or maybe you have a barebones workspace, working at a coffee shop or kitchen table with only a cup of coffee. In the same way, you can have many different environments for how you work with Python: working on a command line, or running scripts. Jupyter Notebooks is an environment that gives you an interactive, browser based version of Python. It allows you to play with code in a way that gives you immediate feedback, and allows you to break, tinker, and retry.

Jupyter Notebooks will be installed through Anaconda.

When programming, you're usually not writing everything from scratch. Some code is needed by many other people, so most languages have a concept of a _library_: code written and distributed by other people that you can easily use in your own work. 

Anaconda is a scientific distribution of Python, which installs Python on your system alongside a great deal of libraries that scientists use.

To be clear: it is possible to install Python in other ways and individually install the libraries, but Anaconda puts it all into a tidy package. Since information scientists want complicated mathematical algorithms, installing some scientific libraries can be very difficult: Anaconda makes it easy!

### Today's Goals

- Install Python, using Anaconda
   - debug?
- Become familiar with Jupyter
- Practice tinkering!

### Keywords

- Anaconda
- Python
- Jupyter
- data types
  - string
  - number
  - list

## 1. Installing Jupyter Notebooks through Anaconda

Install Jupyter Notebooks following the instructions in the *Art of Literary Text Analysis* by Stéfan Sinclair & Geoffrey Rockwell, following the [Getting Setup](https://github.com/sgsinclair/alta/blob/master/ipynb/GettingSetup.ipynb) and [Getting Started](https://github.com/sgsinclair/alta/blob/master/ipynb/GettingStarted.ipynb) (you can stop before the Printing Dynamic Content section).

After you're done installation, start a new notebook and follow along with the tour at Help > User Interface Tour.

_Questions_

- 1) What are the two modes of a notebook?
- 2) What do you press to leave edit mode while in a cell?
- 3) What are the Keyboard Shortcuts for:
 - a) insert cell below
 - b) insert cell above
 - c) run selected cells

## 2. A Little bit of code

Create a new cell in your notebook with the '+' button in the toolbar (or one of the keyboard shortcuts from the previous question). We're going to try two simple Python commands: setting a variable, and splitting it by whitespace. In the process, we'll encounter two types of data that Python can hold: a string, and a list.

Add the following code to the cell and 'run' it. If it runs properly, it should look like below, with the 'In' and 'Out' information.


```python
sentence = "Hello world."
sentence
```




    'Hello world.'



Here, we set a string to a variable, then we called that variable.

_Questions_
- 4) What output is there if you run the cell without the second line (which simply says `sentence`)?

A string is a type of data in Python. By setting it to the variable `sentence`, everywhere you use `sentence` is the exact same as simply writing `"Hello world."` Consider the following examples, or even try them out, which show that the way of joining two strings works the same with a variable or directly with a string:


```python
"Hello world." + " Hello moon."
```




    'Hello world. Hello moon.'




```python
sentence + " Hello moon."
```




    'Hello world. Hello moon.'




```python
sentence + sentence
```




    'Hello world.Hello world.'



We can even see the datatype of a variable with `type()`:


```python
type(sentence)
```




    str



If you have a really long string that needs to go across lines, you can use `\` before the line break to tell Python that _this line of code is not done yet_. Set this famously long sentence from _Paul Clifton_ to the variable `paragraph` in your notebook:


```python
paragraph = "It was a dark and stormy night; the rain fell in torrents — except at occasional intervals, when it was " + \
    "checked by a violent gust of wind which swept up the streets (for it is in London that our scene lies), rattling " + \
    "along the housetops, and fiercely agitating the scanty flame of the lamps that struggled against the darkness."
paragraph
```




    'It was a dark and stormy night; the rain fell in torrents — except at occasional intervals, when it was checked by a violent gust of wind which swept up the streets (for it is in London that our scene lies), rattling along the housetops, and fiercely agitating the scanty flame of the lamps that struggled against the darkness.'



_Questions_ 
- 5) For the code block above, 
  - a) Are the indents necessary for the code to run?
  - b) Are the pluses (+) necessary for the code to run?
  - c) Are the backslashes (\\) necessary for the code to run?
  
_tinker with the code and re-run as necessary_

Another important datatype in Python is the `list`. This is a way to hold multiple things together: strings, numbers, etc. For example:


```python
list_of_strings = ["Never", "gonna", "give", "you", "up"]
list_of_strings
```




    ['Never', 'gonna', 'give', 'you', 'up']




```python
list_of_numbers = [ 4, 8, 15, 16, 23, 42]
list_of_numbers
```




    [4, 8, 15, 16, 23, 42]



Individual objects from a list can be retrieved using a square bracket referencing the place in the list (starting with 0):


```python
list_of_strings[0]
```




    'Hello'




```python
list_of_numbers[1]
```




    8



You can select a list range by specify two numbers in the square brackets with a colon in-between:


```python
list_of_strings[1:4]
```




    ['gonna', 'give', 'you']



Using the colon without a number means _from the very start_ or _until the very end_:


```python
list_of_strings[:4]
```




    ['Never', 'gonna', 'give', 'you']




```python
list_of_strings[1:]
```




    ['gonna', 'give', 'you', 'up']



You can add to a list with `list.append()`:


```python
list_of_strings.append("Word")
list_of_strings
```




    ['Hello', 'world', 'Word', 'Word']



_Questions_

- 6) Can a list have a mix of numbers and strings?
- 7) We joined strings with '+'. What happens if you try to use '+' on two lists?
