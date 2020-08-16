@def title = "Franklin FAQ"

# Franklin FAQ

\style{text-align:center;width:100%;display:inline-block;font-variant-caps:small-caps}{[**Click here to go to the source repo**](https://github.com/tlienart/FranklinFAQ)}

This website is meant to be a quick way to show how to do stuff that people ask (or that I thought would be a nice demo), it will complement the [official documentation](https://franklinjl.org/).

It's not meant to be beautiful, rather just show how to get specific stuff done. If one block answers one of your question, make sure to check [the source](https://github.com/tlienart/FranklinFAQ/blob/master/index.md) to see how it was done.

**Note**: an important philosophy here is that if you can write a Julia function that would produce the HTML you want, then write that function and let Franklin call it.

\toc

## (005) pagination

Pagination works with `{{paginate list num}}` where `list` is a page variable with elements that you want to paginate (either a list or tuple), and `num` is the number of elements you want per page.
There are many ways you can use this, one possible way is to wrap it in a command if you want to insert this in an actual list which is what is demoed here:

\newcommand{\pglist}[2]{~~~<ul>~~~{{paginate #1 #2}}~~~</ul>~~~}

@def alist = ["<li>item $i</li>" for i in 1:10]

\label{pgex}
\pglist{alist}{4}

Now observe that

* [page 1](/1/#pgex) has items 1-4
* [page 2](/2/#pgex) has items 5-8
* [page 3](/3/#pgex) has items 9-10

## (004) use Latexify.jl

Latexify produces a LaTeX string which should basically be passed to KaTeX. To do that you need to recuperate the output, extract the string and pass it into a maths block.

Here there's a bug with `\begin{equation}` in Franklin (issue [#584](https://github.com/tlienart/Franklin.jl/issues/584)) which is why I'm replacing those with `$$` but it should be fixed in the near future so that you wouldn't have to use these two "replace" lines:

```julia:lx1
using Latexify
empty_ary = Array{Float32, 2}(undef, 2, 2)
ls = latexify(empty_ary) # this is an L string
s = replace(ls.s, "\\begin{equation}" => "\$\$") # hide
s = replace(s, "\\end{equation}" => "\$\$") # hide
println(s) # hide
```

\textoutput{lx1}

## (003) styling of code output blocks

At the moment (August 2020) no particular class is added on an output (see [#531](https://github.com/tlienart/Franklin.jl/issues/531)); you can still do something similar by adding a `@@code-output` (or whatever appropriate name) around the command that extracts the output and specify this in your css (see `extras.css`):

```julia:cos1
x = 7
```

@@code-output
\show{cos1}
@@

If you find yourself writing that a lot, you should probably define a command like

```plaintext
\newcommand{\prettyshow}[1]{@@code-output \show{#1} @@}
```

and put it in your `config.md` file so that it's globally available.

\prettyshow{cos1}

## (002) code block scope

On a single page all code blocks share their environment so

```julia:cbs1
x = 5
```

then

```julia:cbs2
y = x+2
```

\show{cbs2}

## (001) how to load data from file and loop over rows

This was asked on Slack with the hope it could mimick the [Data Files](https://jekyllrb.com/docs/datafiles/) functionality of Jekyll where you would have a file like

```
name,github
Eric Mill,konklone
Parker Moore,parkr
Liu Fengyun,liufengyun
```

and you'd want to loop over that and do something with it.

**Relevant pieces**:
* see `_assets/members.csv` (content is the code block above)

### Approach 1, with a `hfun`

* see `utils.jl` for the definition of `hfun_members_table`; calling `{{members_table _assets/members.csv}}` gives

{{members_table _assets/members.csv}}


### Approach 2, with a page variable and a for loop

* see `config.md` for the definition of the `members_from_csv` _global_ page variable.

Writing the following

```html
~~~
<ul>
{{for (name, alias) in members_from_csv}}
  <li>
    <a href="https://github.com/{{alias}}">{{name}}</a>
  </li>
{{end}}
</ul>
~~~
```

gives:

~~~
<ul>
{{for (name, alias) in members_from_csv}}
  <li>
    <a href="https://github.com/{{alias}}">{{name}}</a>
  </li>
{{end}}
</ul>
~~~

**Notes**:
* we use a _global_ page variable so that we don't reload the CSV file every single time something changes on the caller page.
