## Strategies for Using Chat Models

## 1. Describe your question well

The more the chat model knows, the better it can understand your problem. Describe your use case, errors, data, intention. If there's an error message, include it. Remember that the model doesn't know you're working in Python and with Pandas, so also note your tools!

### Example
-  👎 "My Python program isn't working"
- 👍  "I'm getting a 'TypeError: unsupported operand type(s) for +: 'int' and 'str'' error in my Python program when I try to concatenate a string and a number."

## 2. Split up your question into parts

If your problem is complex, try to break it down into manageable parts. 

### Example
if you are trying to web scrape data, store it in a database and then create a visualization from it:
- 👎 describing the full workflow in one question
- 👍 ask separately 1) how to scrape the data, then 2) how to store it, and finally 3) how to visualize it.

Caveats: 1) Sometimes you need fuller context, so split sensibly. 2) Models are getting better at understanding the complex questions and will continue to - though it is also harder for *you* to learn from the all-in-one responses

## 3. Regenerate when needed - the models are stochastic.

The output is randomly determined. If the first response isn't satisfactory, ask again. Different iterations can yield better results. For example, if you're not happy with a code snippet provided, you can ask for another version or approach.

## 4. Rewrite when necessary.

If you're not getting the response you're expecting, consider rewording or rephrasing your question. Sometimes, the model might not fully understand what you're asking, or your question might be too broad or ambiguous.

## 5. Give it your code and examples of your data.

The model can give more precise help if it has concrete information to work with. 

- share an example of your data 
- share your relevant code (formatted with Markdown). 

### Example
- 👎 "my array sorting isn't working"
- 👍 provide the array and the exact sorting code you're using

### Tip

Pandas has a `to_markdown()` method, which will give you an easy-to-copy representation of your table. Combine it with `head()` to only grab a few rows. e.g.

```
md = df.head().to_markdown()
print(md)
```

## 6. Use Markdown for your queries.

When you're discussing code, markdown can be extremely helpful for readability. Use backticks (`) to wrap small pieces of code or triple backticks () for larger blocks of code. 

### Example
The following is surrounded with triple backticks.

```python
test.mean()
```

## 7. Be open to failure.

Don't *expect* the model to always be right - read with caution, like you might with Wikipedia, and allow for the possibility of an incorrect response.

Always double-check and verify the results.

One very common failure: outdated information. The model might not know about changes in a coding library.

## 8. Ask for explanations
Don't hesitate to ask for an explanation of a response. You can ask the model to describe the logic behind a piece of code, clarify how an algorithm works, or explain an error message.

### Example
- 👎 "Thanks for the code."
- 👍 "Can you explain how this part of the code works?"

## 9. Use it as a tool, rather than a silver bullet
- Incorporate it into your routine, but don't rely solely on it.
- You know a lot already. Even in today's chat-model lab, there's no need to ask our models for *everything* -  you're an expert too!
- Bear in mind that using it as a tool is something you get better at with practice, just like you do with programming.

## 10. Use it for your learning

- 👍  "Is there an alternative way to write this code" (compare the approaches)
- 👍 "Below is code I wrote to do X. Suggest notes or improvements, with an explanation.
- 👍 "What are some best practices for writing Python code?"
- 👍 "Can you provide some practice problems to improve my skills with `groupby` in Pandas?"
- 👍 Test yourself: "This is my understanding of how an Inner Join works in SQL, is this correct?"

## 11. Have it help with adjacent skills

### Example
You know how to scrape a web table with `pd.read_html`, but what if you want to read multiple tables from a list of URLs and concatenate them into a single dataset? A chat model can help nudge your abilities into the novel.

## 12. Use it for brainstorming
AI models can be useful tools for brainstorming. Talk with it about ideas. It's stronger if you describe your *existing* ideas, to better understand what you're getting at.

### Example
👍 "I'm trying to study Y. What are sensible questions to answer in my study? Suggest additional datasets that would be sensible to compare against."

## 13. Translate skills and jargon across tools and domains

If you know how to do something in one tool, chat models can help you learn how to adapt it to a different tool, syntax, etc.

### Example
👍 "How would I write this R code as Python?"
